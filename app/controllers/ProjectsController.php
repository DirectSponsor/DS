<?php
class ProjectsController extends BaseController{

    public function __construct(){
        $this->beforeFilter('auth',array('only'=> array( 
            'index', 'myProject', 'create', 'store', 'show', 'edit', 'update', 'close', 'open', 'joinProject', 'joinProjectAction', 'withdraw'
        )));
    }

    public function index(){
        $projects = Project::all();
        $this->render('projects.index','Projects',array('projects'=>$projects));
    }

    public function joinProject(){
        $accountType = Auth::user()->account_type;
        if($accountType != 'Sponsor') return Redirect::route('notFound');
        $sponsorProjectsIds = Auth::user()->account->projects->lists('id');
        if(empty($sponsorProjectsIds))
            $projects = Project::where('open','=',true)->get();
        else
            $projects = Project::whereNotIn('id',$sponsorProjectsIds)->where('open','=',true)->get();
        $this->render('projects.sponsor_join','Join A Project',array(
            'projects' => $projects
        ));
    }

    public function joinProjectAction($pid){
        $accountType = Auth::user()->account_type;
        $project = Project::find($pid);
        if($accountType != 'Sponsor') return Redirect::route('permissionsDenied');
        if(is_null($project)) return Redirect::route('notFound');
        $sponsor = Auth::user()->account;

        $rid = $project->getFreeRecipient();
        if($rid){
            DB::table('project_sponsor')->insert(array(
                'sponsor_id' => $sponsor->id,
                'recipient_id' => $rid,
                'project_id' => $project->id
            ));

            $recipient = Recipient::find($rid);

            $payment = new Payment;
            $payment->project_id = $project->id;
            $payment->sender_id = $sponsor->user->id;
            $payment->receiver_id = $recipient->user->id;
            $payment->type = "sponsoring";
            $payment->stat = "pending";
            $payment->save();

            Mail::send('emails.sponsors.joining', array(
                    'name'=>$sponsor->name,
                    'id'=>$sponsor->id,
                    'project' => $project,
                    'recipientSkrill' => $recipient->skrill_acc
                ), function($message){
                $message->to(Auth::user()->email)->subject('Thank you for joining new project');
            });

            Session::put('success','You have joined the project "'.$project->name.'" Please check your email inbox to make your first payment !');
            return Redirect::route('joinProject');
        }else{
            Session::put('error','There is no empty place on this peoject currently. Please retry later ');
            return Redirect::route('joinProject');
        }
    }

    public function myProject(){
        $user = Auth::user();
        switch($user->account_type){
            case 'Admin' :
                return Redirect::route('projects.index');
            break;
            case 'Coordinator' :
                $project = Project::find($user->account->project_id);
                $this->render('projects.show',$project->name,array(
                    'project' => $project
                ));
            break;
            case 'Recipient' :
                $project = Project::find($user->account->project_id);
                $sponsors = $user->account->sponsors;
                $this->render('projects.show',$project->name,array(
                    'project' => $project,
                    'sponsors' => $sponsors
                ));
            break;
            case 'Sponsor' :
                $this->render('projects.index','My Projects',array(
                    'projects' => $user->account->projects
                ));
            break;
        }
    }

    public function create(){
        $this->render('projects.create','Add new project');
    }

    public function store(){
        $project = new Project;
        $project->url = str_replace(" ", "_", strtolower(e(Input::get('name'))));
        $project->open = true;
        $coordinator = new Coordinator;
        $user = new User;

        $user->account_type = 'Coordinator';
        User::$rules['password'] = 'required|min:6';

        if($project->save()){
            if($user->save()){
                $coordinator->project_id = $project->id;
                $coordinator->user_id = $user->id;
                $coordinator->save();
                Session::put('success','Project has been added !');
                return Redirect::route('projects.show',$project->url);
            }else{
                $project->delete();
                Session::put('error','There were some errors !');
                return Redirect::route('projects.create')->withErrors($user->errors())->withInput();
            }
        }else{
            Session::put('error','There were some errors !');
            if($user->save()) $user->delete();
            return Redirect::route('projects.create')->withErrors($project->errors())->withInput();
        }
    }

    public function show($url){
        $project = Project::where('url','=',$url)->first();
        if(is_null($project)){
            return Redirect::route('notFound');
        }else{
            $this->render('projects.show','Project: '.$project->name,array('project'=>$project));
        }
    }

    public function edit($url){
        $project = Project::where('url','=',$url)->first();
        if(is_null($project)){
            return Redirect::route('notFound');
        }else{
            $this->render('projects.edit','Edit: '.$project->name,array('project'=>$project));
        }
    }

    public function update($id){
        $project = Project::find($id);
        Project::$rules['name'] = 'required|min:3|unique:projects,name,'.$id;
        $project->url = str_replace(" ", "_", strtolower(e(Input::get('name'))));
        //... checking if max recipients and max sponsors entered are not less then current ones !!
        if($project->save()){
            Session::put('success','Project editted successfully !');
            return Redirect::route('projects.show',$project->url);
        }else{
            Session::put('error','There were some errors !');
            return Redirect::route('projects.edit',$project->url)->withErrors($project->errors())->withInput();
        }
    }


    public function close($id){
        $project = Project::find($id);
        $project->open = false;
        $project->forceSave();
        Session::put('error','The project \''.$project->name.'\' has been closed !');
        return Redirect::route('projects.index');
    }

    public function open($id){
        $project = Project::find($id);
        $project->autoHydrateEntityFromInput = false;    
        $project->forceEntityHydrationFromInput = false; 
        $project->open = true;
        $project->forceSave();
        Session::put('success','The project \''.$project->name.'\' has been opened !');
        return Redirect::route('projects.index');
    }

    public function withdraw($id){
        $accountType = Auth::user()->account_type;
        $project = Project::find($id);
        if($accountType != 'Sponsor') return Redirect::route('permissionsDenied');
        if(is_null($project)) return Redirect::route('notFound');
        $sponsor = Auth::user()->account;

        DB::table('project_sponsor')->where('sponsor_id','=',$sponsor->id)
            ->where('project_id', '=', $id)
            ->delete();
        
        Session::put('info','You don\'t sponsorise the project "'.$project->name.'" anymore. You can still rejoin the project later if you want.');
        return Redirect::route('myProject');
    }
}
