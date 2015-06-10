<?php
class SpendsController extends BaseController{

public function __construct(){
        $this->beforeFilter('auth',array('only'=> array( 
            'index','create','store','destroy'
        )));
    }

    public function myActivities(){
        $accountType = Auth::user()->account_type;
        if($accountType != 'Coordinator') return Redirect::route('permissionsDenied');
        $project = Auth::user()->account->project;
        $spends = $project->spends;
        $this->render('spends.index',$project->name.' > Activities',array(
            'project' => $project,
            'spends' => $project->spends
        ));
    }

    public function index($pid){
        $accountType = Auth::user()->account_type;
        $project = Project::find($pid);
        if($accountType == 'Coordinator'){
            $myProjectId = Auth::user()->account->project_id;
            if($pid != $myProjectId) return Redirect::route('permissionsDenied');
        }
        if(is_null($project)) return Redirect::route('notFound');
        $this->render('spends.index',$project->name.' > Activities',array(
            'project' => $project,
            'spends' => $project->spends
        ));
    }

    public function create($pid){
        $accountType = Auth::user()->account_type;
        $project = Project::find($pid);
        if($accountType != 'Admin' && $accountType != 'Coordinator') return Redirect::route('permissionsDenied');
        if($accountType == 'Coordinator'){
            $myProjectId = Auth::user()->account->project_id;
            if($pid != $myProjectId) return Redirect::route('permissionsDenied');
        }
        $this->render('spends.create',$project->name.' > Add Activity :',array('project'=>$project));
    }

    public function store($pid){
        $spend = new Spend;
        $spend->project_id = $pid;
        if($spend->save()){
            Session::put('success','Activity added with success !');
            return Redirect::route('projects.spends.index',$pid);
        }else{
            Session::put('error','There was some errors !');
            return Redirect::route('projects.spends.create',$pid)->withErrors($spend->errors())->withInput();
        }
    }

    public function destroy($pid,$id){
        $project = Project::find($pid);
        if(is_null($project)) return Redirect::route('notFound');
        $spend = Spend::find($id);
        $spend->delete();
        Session::put('error','Activity deleted !');
        return Redirect::route('projects.spends.index',$pid);
    }
}