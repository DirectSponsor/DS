<?php

class Project extends \LaravelBook\Ardent\Ardent {
	protected $guarded = array();
	public static $rules = array(
        'name' => 'required|min:3|unique:projects',
        'content' =>'required',
        'max_recipients' => 'required|numeric',
        'max_sponsors_per_recipient' => 'required|numeric',
        'currency' => 'required',
        'amount' => 'required|numeric',
        'euro_amount' => 'required|numeric',
        'gf_commission' => 'required|numeric'
    );
    protected $fillable = array('name','content','max_recipients','max_sponsors_per_recipient','currency','amount','euro_amount','gf_commission');
    public $autoHydrateEntityFromInput = true;    // hydrates on new entries' validation
    public $forceEntityHydrationFromInput = true; // hydrates whenever validation is called

    public static $relationsData = array(
        'coordinator' => array(self::HAS_ONE, 'Coordinator'),
        'recipients' => array(self::HAS_MANY, 'Recipient'),
        'sponsors' => array(self::BELONGS_TO_MANY, 'Sponsor','project_sponsor'),
        'invitations' => array(self::HAS_MANY, 'Invitation'),
        'payments' => array(self::HAS_MANY, 'Payment'),
        'spends' => array(self::HAS_MANY, 'Spend')
    );

    public function hasSponsorPlace(){
        foreach ($this->recipients as $recipient){
            if($recipient->confirmed){
                if(is_null($recipient->sponsors))
                    return true;
                else{
                    $count = $recipient->sponsors->count();
                    // foreach ($recipient->sponsors as $sponsor){
                    //     if($sponsor->hasNotPaid($this->id))
                    //         $count --;
                    // }
                    if($count < $this->max_sponsors_per_recipient)
                        return true;
                }
            }
        }
        return false;
    }

    // Recipients:
    public function getFreeRecipient(){
        foreach ($this->recipients as $recipient){
            if($recipient->confirmed &&
                (is_null($recipient->sponsors) || $recipient->sponsors->count() < $this->max_sponsors_per_recipient))
                return $recipient->id;
        }
        return false;
    }

    // Sponsors:
    public function paymentsOfSponsor($sid){
        return Sponsor::find($sid)->paymentsOfProject($this->id);
    }

    public function recipientOfSponsor($sid){
        return Sponsor::find($sid)->recipientOfProject($this->id);
    }

    public function confirmedPaymentsOfSponsor($sid){
        return $this->paymentsOfSponsor($sid)->where('stat','=','accepted');
    }
    // public function notPaidBy($sid){
    //     if(count($this->ConfirmedPaymentsBy($sid)) == 0)
    //         return true;
    //     return false;
    // }

    public function getMaxSponsorsNumber(){
        $recipients = $this->recipients;
        $max = 0;
        foreach ($recipients as $recipient){
            if($recipient->sponsors->count() > $max)
                $max = $recipient->sponsors->count();
        }
        return $max;
    }

}
