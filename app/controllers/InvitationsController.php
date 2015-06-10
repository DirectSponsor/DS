<?php
class InvitationsController extends BaseController{

    public function __construct(){
        $this->beforeFilter('auth',array('only'=> array( 
            'index','create','store'
        )));
    }

    public function index($pid){
        $project = Project::find($pid);
        if(is_null($project)) return Redirect::route('notFound');
        $this->render('invitations.index',$project->name.' > Invitations',array(
            'invitations' => $project->invitations,
            'pid' => $pid
        ));
    }

    public function create($pid){
        $project = Project::find($pid);
        $this->render('invitations.create',$project->name.' > Send new invitation',array(
            'pid' => $pid
        ));
    }

    public function store($pid){
        $invitation = new Invitation;
        $invitation->project_id = $pid;
        // Generating the invitation's url
        do{
            $url = str_replace('/','',substr(Hash::make($pid.e(Input::get('sent_to')).rand(15,1000)), 51));
            $count = Invitation::where('url','=',$url)->count();
        }while($count > 0);
        $invitation->url = $url;
        
        if($invitation->save()){
            // Send the invitation
            $project = Project::find($pid);
            Mail::send('emails.recipients.invitation', array('name'=>$project->name,'url'=>$url), function($message){
                $message->to(Input::get('sent_to'))->subject('Invitation to Direct Sponsor');
            });

            Session::put('success','Invitation sent successfuly !');
            return Redirect::route('projects.invitations.index',$pid);
        }else{
            Session::put('error','There was some errors !');
            return Redirect::route('projects.invitations.index',$pid)->withErrors($invitation->errors())->withInput();
        }
    }
}