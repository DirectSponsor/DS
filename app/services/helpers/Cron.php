<?php namespace Services\Helpers;
use \Datetime;
use \DB;
use \Project;
use \Sponsor;
use \Recipient;
use \Mail;

class Cron {
    // Log parametres
    private static $logFile;

    // Mails parametres
    public static $destination;
    public static $cc;
    public static $title;

    // Functions
    public static function run(){ // This will run all checks
        // Opens log file
        static::$logFile = fopen(__DIR__.'/cron_jobs_log.txt', "a");
        
        // Checks
        static::checkSponsorsPayments();

        fclose(static::$logFile); // Closes log file
    }



    public static function checkSponsorsPayments(){
        $now = new DateTime();
        $pivots = DB::table('project_sponsor')->get();
        foreach($pivots as $pivot){
            $date = new DateTime($pivot->next_pay);
            if($now > $date){
                $delay = $date->diff($now)->d;
                $sponsor = Sponsor::find($pivot->sponsor_id);
                $recipient = Recipient::find($pivot->recipient_id);
                $project = Project::find($pivot->project_id);
                $coordinator = $project->coordinator;
                if($delay == 3){ // First Warning

                //do not warn the sponsor before confirming with recipient
		/*    static::sendMail(
                        'emails.sponsors.no_payment',
                        array(
                            'sponsorName' => $sponsor->name,
                            'recipientName' => $recipient->name,
                            'date' => $now->format('F d Y')
                        ), $sponsor->user->email,
                        'Warning, we did not received your payment !',
                        array(
                            'accounts@directsponsor.org',
                            $coordinator->user->email
                        )
                    ); */

                    static::sendMail(
                        'emails.recipients.no_payment',
                        array(
                            'sponsorName' => $sponsor->name,
                            'recipientName' => $recipient->name,
                            'date' => $now->format('F d Y')
                        ), $recipient->user->email,
                        'Warning, sponsor payment was not added !',
                        array(
                            'accounts@directsponsor.org',
                            $coordinator->user->email
                        )
                    );

                }
                if($delay == 10){ // Second Warning
                    $limit = $date;
                    $limit->modify('+30 days');
                    static::sendMail(
                        'emails.sponsors.no_payment_after',
                        array(
                            'sponsorName' => $sponsor->name,
                            'recipientName' => $recipient->name,
                            'date' => $limit->format('F d Y')
                        ), $sponsor->user->email,
                        'Warning, we did not yet received your payment !',
                        array(
                            'accounts@directsponsor.org',
                            $coordinator->user->email
                        )
                    );

                    static::sendMail(
                        'emails.recipients.no_payment_after',
                        array(
                            'sponsorName' => $sponsor->name,
                            'recipientName' => $recipient->name,
                            'date' => $now->format('F d Y')
                        ), $recipient->user->email,
                        'Warning, sponsor payment was not added !',
                        array(
                            'accounts@directsponsor.org',
                            $coordinator->user->email
                        )
                    );
                }
                if($delay == 30){ // Suspend Sponsor
                    $pivot->delete();
                    static::myLog('the sponsor "'.$sponsor->name.'" was deleted from project "'.$project->name.'"');
                }
            }
        }
    }

    // Mail Functions
    public static function sendMail($view, $data, $destination, $title, $cc = array()){
        static::$destination = $destination;
        static::$cc = $cc;
        static::$title = $title;
        Mail::send($view, $data, function($message){
            foreach(Cron::$cc as $addr){
                $message->cc($addr);
            }
            $message->to(Cron::$destination)
                ->subject(Cron::$title);
        });
    }

    // Log Functions
    public static function myLog($msg){
        fwrite(static::$logFile,$msg."\n");
    }
}
