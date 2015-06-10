<?php
class CoordinatorsController extends BaseController{

    public function __construct(){
        $this->beforeFilter('auth',array('only'=> array( 
            'index','show'
        )));
    }

    public function index(){
        $coords = Coordinator::all();
        $this->render('coordinators.index','Coordinators',array(
            'coords' => $coords
        ));
    }

    public function show($id){
        $coord = Coordinator::find($id);
        if(is_null($coord)){
            return Redirect::route('notFound');
        }
        $this->render('coordinators.show','',array(
            'coord' => $coord
        ));
    }
}
