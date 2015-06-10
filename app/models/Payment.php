<?php

class Payment extends \LaravelBook\Ardent\Ardent {
	protected $guarded = array();
	public static $rules = array();

    public $autoHydrateEntityFromInput = true;    // hydrates on new entries' validation
    public $forceEntityHydrationFromInput = true; // hydrates whenever validation is called

    public static $relationsData = array(
        'project' => array(self::BELONGS_TO, 'Project'),
        'sender' => array(self::BELONGS_TO, 'User', 'sender_id'),
        'receiver' => array(self::BELONGS_TO, 'User', 'receiver_id')
    );
}
