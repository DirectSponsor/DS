<?php

class Coordinator extends \LaravelBook\Ardent\Ardent {
	protected $guarded = array();
	public static $rules = array();

    public $autoHydrateEntityFromInput = true;    // hydrates on new entries' validation
    public $forceEntityHydrationFromInput = true; // hydrates whenever validation is called

    public static $relationsData = array(
        'project' => array(self::BELONGS_TO, 'Project'),
        'user' => array(self::BELONGS_TO, 'User')
    );

    public function receivedPaymentsbySponsor(){
    	return $this->user->receivedPaymentsbySponsor();
    }
    public function receivedPayments(){
        return $this->user->receivedPayments();
    }
}
