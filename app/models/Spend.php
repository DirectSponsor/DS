<?php

class Spend extends \LaravelBook\Ardent\Ardent {
	protected $guarded = array();
	public static $rules = array(
        'amount' => 'required|numeric',
        'description' =>'required'
    );

    public $autoHydrateEntityFromInput = true;    // hydrates on new entries' validation
    public $forceEntityHydrationFromInput = true; // hydrates whenever validation is called

    public static $relationsData = array(
        'project' => array(self::BELONGS_TO, 'Project')
    );

    public function coordinator(){
        return Project::find($this->project_id)->coordinator();
    }
}
