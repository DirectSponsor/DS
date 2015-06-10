<?php
class SponsorsController extends BaseController{

    public function __construct(){
        $this->beforeFilter('auth',array('only'=> array(
            'index','mySponsors','perProject','show','suspend','activate'
        )));
    }

    public function index(){
        $sponsors = Sponsor::all();
        $this->render('sponsors.index','Sponsors',array('sponsors'=>$sponsors));
    }

    public function mySponsors(){
        $user = Auth::user();
        switch($user->account_type){
            case 'Admin' :
                return Redirect::route('sponsors.index');
            break;
            case 'Coordinator' :
                $sponsors = $user->account->project->sponsors;
                $this->render('sponsors.index','My Sponsors',array(
                    'sponsors' => $sponsors
                ));
            break;
            case 'Recipient' :
                $sponsors = $user->account->sponsors;
                $this->render('sponsors.index','My Sponsors',array(
                    'sponsors' => $sponsors
                ));
            break;
            default:
                return Redirect::route('notFound');
        }
    }

    public function join($url){
        $project = Project::where('url','=',$url)->first();
        if(is_null($project)){
            return Redirect::route('notFound');
        }
        if(!$project->open){
            $this->render('static.message','Project closed !',array(
                'msg' => 'You can\'t join this project because it is closed now !' 
            ));
            return;
        }
        if(!$project->hasSponsorPlace()){
            $this->render('static.message','All availabe places are now full',array(
                'msg' => 'You can\'t join this project because all available recipients gave their max number of sponsors. Please try again later' 
            ));
            return; 
        }
        $this->render('sponsors.join','Join '.$project->name,array(
            'pid' => $project->id
        ));
    }

    public function register($id){
        $project = Project::find($id);
        if(is_null($project)){
            return Redirect::route('notFound');
        }
        if(!$project->open){
            $this->render('static.message','Project closed !',array(
                'msg' => 'You can\'t join this project because it is closed now !' 
            ));
            return;
        }
        if(!$project->hasSponsorPlace()){
            $this->render('static.message','All availabe places are now full',array(
                'msg' => 'You can\'t join this project because all available recipients gave their max number of sponsors. Please try again later' 
            ));
            return;
        }
		
        $sponsor = new Sponsor;
        $user = new User;
        $user->account_type = 'Sponsor';
        if(Input::get('password') == Input::get('password_confirmation'))
            User::$rules['password'] = 'required|min:6';
        	//User::$rules['skrill_acc'] = 'required|email';
        	if($user->save()){
            	$sponsor->user_id = $user->id;
	            Input::merge(array('suspended' => 0));
    	        Input::merge(array('confirmed' => 0));

        	    if(e(Input::get('skrill_acc')) == '') 
                	Input::merge(array('skrill_acc' => Input::get('email')));
            		if($sponsor->save()){
                		$rid = $project->getFreeRecipient();
                		if($rid){
		                    DB::table('project_sponsor')->insert(array(
        	                'sponsor_id' => $sponsor->id,
            	            'recipient_id' => $rid,
                	        'project_id' => $project->id
                    	));
                	}
                	else
                	{
                    	$user->delete();
	                    $sponsor->delete();
    	                return Redirect::route('sponsors.join',$project->url);
                	}
                	
                	$mepsa = Recipient::find($rid)->mepsa;
                	if($mepsa== NULL|| $mepsa=""): $mepsa = "Not Available"; endif;
	                Mail::send('emails.sponsors.confirmation', array(
                        'name' => $sponsor->name,
                        'hash' => Hash::encrypt($sponsor->id),
                        'project' => $project,
                        'recipientSkrill' => Recipient::find($rid)->skrill_acc,
                        'recipientMEPSA' => $mepsa,
                        'recipientNAME' => Recipient::find($rid)->name
                    ), function($message){
                    $message->to(Input::get('email'))->subject('Sponsor account created !');
                });
                Session::put('success','Your sponsor account was successfully created !');
                // return Redirect::route('login.form');
                $this->render('static.message','Thanks for joining us !', array(
                    'msg' => 'Please check your inbox to confirm you account'
                ));
            }else{
                $user->delete();
                Session::put('error','There were some errors !');
                return Redirect::route('sponsors.join',$project->url)->withErrors($sponsor->errors())->withInput();
            }
        }else{
            Session::put('error','There were some errors !');
            return Redirect::route('sponsors.join',$project->url)->withErrors($user->errors())->withInput();
        }
    }

    public function show($id){
        $sponsor = Sponsor::find($id);
        if(is_null($sponsor)){
            return Redirect::route('notFound');
        }
        $this->render('sponsors.show','Sponssor: '.$sponsor->user->username,array(
            'sponsor' => $sponsor
        ));
    }

    public function confirm($hash){
        $id = Hash::decrypt($hash);
        $sponsor = Sponsor::find($id);
        if(is_null($sponsor)) return Redirect::route('notFound');
        $sponsor->confirmed = true;
        $sponsor->forceSave();
        
        $projectId = $sponsor->projects->first()->id;
        $recipient = $sponsor->recipientOfProject($projectId);
        $payment = new Payment;
        $payment->project_id = $projectId;
        $payment->sender_id = $sponsor->user_id;
        $payment->receiver_id = $recipient->user_id;
        $payment->type = "sponsoring";
        $payment->stat = "pending";
        $payment->forceSave();

        Auth::logout();
        Session::put('success','Your email adress was confirmed ! <br> You can now Login to your account ');
        return Redirect::route('login.form');
    }

    public function suspend($id,$pid){
        $sponsor = Sponsor::find($id);
        if(is_null($sponsor)){
            return Redirect::route('notFound');
        }
        // Detach sponsor from recipient !
        DB::table('project_sponsor')->where('sponsor_id','=',$id)
            ->where('project_id','=',$pid)
            ->delete();
        Session::put('error','The sponsor\'s account has been suspended from the selected project !');
        return Redirect::route('sponsors.index');
    }
    
    public function projects($id){
        $sponsor = Sponsor::find($id);
        if(is_null($sponsor)){
            return Redirect::route('notFound');
        }
        $this->render('sponsors.projects','Projects of the sponsor '.$sponsor->user->username,array(
            'projects' => $sponsor->projects,
            'sid' => $id
        ));
    }
}