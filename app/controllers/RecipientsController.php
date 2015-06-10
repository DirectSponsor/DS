<?php
class RecipientsController extends BaseController{

    public function __construct(){
        $this->beforeFilter('auth',array('only'=> array( 
            'index', 'myRecipients', 'perProject', 'show'
        )));
    }

    public function index(){
        $recipients = Recipient::all();
        $this->render('recipients.index','Recipients',array(
            'recipients' => $recipients
        ));
    }
    public function myRecipients(){
        $user = Auth::user();
        switch($user->account_type){
            case 'Admin':
                return $this->index();
            break;
            case 'Coordinator':
                $recipients = $user->account->project->recipients;
                $this->render('recipients.index','My Recipients',array(
                    'recipients' => $recipients
                ));
            break;
            default:
                return Redirect::route('notFound');
        }
    }

    public function perProject($id){
        $project = Project::find($id);
        if(is_null($project)) return Redirect::route('notFound');
        $recipients = $project->recipients;
        $this->render('recipients.index',
            'Project : '.$project->name.' > Recipients',
            array('recipients' => $recipients));
    }

    public function confirm($hash){
        $id = Hash::decrypt($hash);
        $recipient = Recipient::find($id);
        if(is_null($recipient)) return Redirect::route('notFound');
        $recipient->confirmed = true;
        $recipient->forceSave();
        Auth::logout();
        Session::put('success','Your email adress was confirmed ! <br> You can now Login to your account ');
        return Redirect::route('login.form');
    }

    public function join($url){
        $invitation = Invitation::where('url','=',$url)->first();
        if(is_null($invitation)){
            return Redirect::route('notFound');
        }
        if(! $invitation->project->open)
            $this->render('recipients.closed_project');
        $this->render('recipients.join',
            'Recipient register for the project : '.$invitation->project->name,array('url'=>$url));
    }

    public function register($url){
        $invitation = Invitation::where('url','=',$url)->first();
        if(is_null($invitation)) return Redirect::route('notFound');
        // .... check if there is places for recipients in the project !
        $user = new User;
        $recipient = new Recipient;
        $user->account_type = 'Recipient';
        if(Input::get('password') == Input::get('password_confirmation'))
            User::$rules['password'] = 'required|min:6';
        if($user->save()){
            $recipient->user_id = $user->id;
            $recipient->project_id = $invitation->project_id;
            if(e(Input::get('skrill_acc')) == '') Input::merge(array('skrill_acc' => Input::get('email')));
            if($recipient->save()){
                $invitation->delete();
                Session::flash('email',$user->email);
                Mail::send('emails.recipients.confirm', array(
                    'name' => $recipient->name,
                    'hash' => Hash::encrypt($recipient->id)
                    ), function($message){
                    $message->to(Session::get('email'))->subject('Confirm your Direct Sponsor account');
                });
                Session::put('success','Your recipient account was successfully created ! an email has been sent to you to confirm your email '.$user->email);
                return Redirect::route('login.form');
            }else{
                $user->delete();
                Session::put('error','There was some errors !');
                return Redirect::route('recipients.join',$invitation->url)->withErrors($recipient->errors())->withInput();
            }
        }else{
            Session::put('error','There was some errors !');
            return Redirect::route('recipients.join',$invitation->url)->withErrors($user->errors())->withInput();
        }
    }

    public function show($id){
        $recipient = Recipient::find($id);
        if(is_null($recipient)) return Redirect::route('notFound');
        $this->render('recipients.show','Recipient: '.$recipient->name,array(
            'recipient' => $recipient
        ));
    }
}
