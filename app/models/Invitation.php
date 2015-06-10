<?php

class Invitation extends \LaravelBook\Ardent\Ardent {
	protected $guarded = array();
	public static $rules = array(
        'sent_to' => 'required|email'
    );
    public static $customMessages = array(
        'required' => 'This field is required !',
        'email' => 'The Email you entered is invalid !'
    );
    protected $fillable = array('sent_to');

    public $autoHydrateEntityFromInput = true;    // hydrates on new entries' validation
    public $forceEntityHydrationFromInput = true; // hydrates whenever validation is called

    public static $relationsData = array(
        'project' => array(self::BELONGS_TO, 'Project')
    );
}
