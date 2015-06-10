<?php

class Sponsor extends \LaravelBook\Ardent\Ardent {
	protected $guarded = array();
	public static $rules = array(
        'name' => 'required|min:3',
        'skrill_acc' => 'unique:sponsors|email'
    );

    public $autoHydrateEntityFromInput = true;    // hydrates on new entries' validation
    public $forceEntityHydrationFromInput = true; // hydrates whenever validation is called
    protected $fillable = array('name','skrill_acc');


    public static $relationsData = array(
        'user' => array(self::BELONGS_TO, 'User'),
        'projects' => array(self::BELONGS_TO_MANY, 'Project', 'project_sponsor'),
        'recipients' => array(self::BELONGS_TO_MANY, 'Recipient','table' => 'project_sponsor')
    );

    public function recipientOfProject($pid){
        $rid = DB::table('project_sponsor')->where('sponsor_id','=',$this->id)
            ->where('project_id','=',$pid)
            ->first()->recipient_id; 
        return Recipient::find($rid);
    }

    public function payments(){
        return $this->user->sentPayments();
    }

    public function paymentsOfProject($pid){
        return $this->payments()->where('project_id','=',$pid);
    }
}
