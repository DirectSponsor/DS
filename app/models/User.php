<?php

use Illuminate\Auth\UserInterface;
use Illuminate\Auth\Reminders\RemindableInterface;

class User extends \LaravelBook\Ardent\Ardent implements UserInterface, RemindableInterface {
	protected $table = 'users';
	
	protected $guarded = array();
	public static $rules = array(
		'username' => 'required|unique:users',
        'email' => 'required|email|unique:users',
		'password' => 'required|min:6|confirmed'
	);

	public $autoHydrateEntityFromInput = true;    // hydrates on new entries' validation
    public $forceEntityHydrationFromInput = true; // hydrates whenever validation is called
    public static $passwordAttributes  = array('password');
    public $autoHashPasswordAttributes = true;
    protected $fillable = array('username','email','password');

    public function setFillable($fields){
        $this->fillable = $fields;
    }

    public static $relationsData = array(
        'sentPayments' => array(self::HAS_MANY, 'Payment', 'foreignKey' => 'sender_id'),
        'receivedPayments' => array(self::HAS_MANY, 'Payment', 'foreignKey' => 'receiver_id'),
    );

    public function account(){
    	switch($this->account_type){
    		case 'Admin':
    			return null;
    		break;
    		case 'Coordinator':
    			return $this->hasOne('Coordinator');
    		break;
    		case 'Recipient':
    			return $this->hasOne('Recipient');
    		break;
    		case 'Sponsor':
    			return $this->hasOne('Sponsor');
    		break;
    	}
    }

	public function getAuthIdentifier(){
		return $this->getKey();
	}
	public function getAuthPassword(){
		return $this->password;
	}
	public function getReminderEmail(){
		return $this->email;
	}

}