<?php
class BaseController extends Controller {
	public $layout = 'layouts.cpanel';
	
	protected function setupLayout(){}
	protected function render($view,$title = false,$data = array()){
	    $l = $this->layout;
	    $this->layout = View::make($this->layout);
	    if($title){
		    $this->layout->title = $title;
	    }
	    if(Session::has('error')){
	        $this->layout->error = Session::get('error'); 
	        Session::forget('error');   
	    }
	    if(Session::has('success')){
	        $this->layout->success = Session::get('success'); 
	        Session::forget('success');
	    }
	    if(Session::has('info')){
	        $this->layout->info = Session::get('info'); 
	        Session::forget('info');    
	    }
	    // General Messages:
	    if(Auth::check()){
	    	$user = Auth::user();
	    	if($user->role_id == 4){
	    		$sponsor = $user->sponsor;
	    		if($sponsor->hasNotPaidProjects()){
	    			$this->layout->notification = 'You have not paid projects yet. Please add payment for your project as soon as possible !';
	    		}
	    	}
	    }

	    $this->layout->content = View::make($view)->with($data);
	}
}