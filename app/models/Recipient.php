<?php

class Recipient extends \LaravelBook\Ardent\Ardent {
	protected $guarded = array();
	public static $rules = array(
        'name' => 'required|min:3',
        'skrill_acc' => 'email|unique:recipients'
    );

    public $autoHydrateEntityFromInput = true;    // hydrates on new entries' validation
    public $forceEntityHydrationFromInput = true; // hydrates whenever validation is called
    protected $fillable = array('name','skrill_acc','mepsa');

    public static $relationsData = array(
        'project' => array(self::BELONGS_TO, 'Project'),
        'user' => array(self::BELONGS_TO, 'User'),
        'sponsors' => array(self::BELONGS_TO_MANY, 'Sponsor', 'table'=>'project_sponsor')
    );

    public function sentPayments(){
        return $this->user->sentPayments();
    }

    public function receivedPayments(){
        return $this->user->receivedPayments();
    }

}
