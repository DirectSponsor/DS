<?php
class PaymentsController extends BaseController{
	public function __construct(){
	    $this->beforeFilter('auth',array('only'=> array( 
            'index', 'myTransactions', 'accept', 'reject', 'add', 'save'
        )));
	}

    public function index(){
        if(Auth::user()->account_type != 'Admin')
            return Redirect::route('myTransactions');
        $payments = Payment::all();
        $this->render('payments.index','Transactions',array(
            'payments' => $payments
        ));
    }
    public function transactionsByIds($sponsor_id, $recipient_id)
    {
    	$receivedPaymentsbySponsor = DB::table('payments')->select('updated_at')
    	->where('sender_id','=',$sponsor_id)
    	->where('receiver_id','=',$recipient_id)
    	->orderBy('updated_at', 'desc')
    	->first();
    	//->get();
    	return  $receivedPaymentsbySponsor->updated_at;
    	//dd(DB::getQueryLog());
    }
    public function myTransactions(){
        $user = Auth::user();
        switch($user->account_type){
            case 'Admin' :
                return Redirect::route('payments.index');
            break;
            case 'Coordinator' :
                $payments = $user->account->receivedPayments;
                $this->render('payments.index','Received Transactions',array(
                    'payments' => $payments
                ));
            break;
            case 'Recipient' :
                $payments = $user->account->receivedPayments;
                $this->render('payments.index','Received Transactions',array(
                    'payments' => $payments
                ));
            break;
            case 'Sponsor' :
                $payments = $user->account->payments;
                $this->render('payments.index','My Transactions',array(
                    'payments' => $payments
                ));
            break;
            default:
                return Redirect::route('notFound');
        }
    }

    public function accept($id){
    	//echo '<script>alert('.$id.')</script>';
    	//die();
        $payment = Payment::find($id);
        $user = Auth::user();
        if(is_null($payment)) 
            return Redirect::route('notFound');
        if($user->id != $payment->receiver->id || $user->account_type == 'Admin' || $user->account_type == 'Sponsor')
            return Redirect::route('permissionsDenied');

        $payment->stat = 'accepted';
        $payment->forceSave();

        if($user->account_type == 'Recipient'){
            // The recipient accepts payment from sponsor,
            // So update next payment date for this sponsor
            $sid = $payment->sender->account->id;
            $date = DB::table('project_sponsor')
                ->where('sponsor_id','=',$sid)
                ->where('project_id','=',$payment->project_id)
                ->first()
                ->next_pay;
            $date = new DateTime($date);
            $date->modify('+1 month');
            $date = DB::table('project_sponsor')
                ->where('sponsor_id','=',$sid)
                ->where('project_id','=',$payment->project_id)
                ->update(array('next_pay'=>$date->format('Y-m-d 00:00:00')));
            
            // And Create a payment to coordinator from this recipient
            $payment2 = new Payment;
            $payment2->project_id = $payment->project_id;
            $payment2->sender_id = $user->id;
            $payment2->receiver_id = $payment->project->coordinator->user_id;
            $payment2->type = "group fund";
            $payment2->stat = "pending";
            $payment2->save();
            Session::put('success','Transaction was successfuly confirmed !');
            Session::put('info','Please make sure you sent the group fund commission to coordinator !');
            return  Redirect::route('myTransactions');
        }else{ // So it's Coordinator !
            Session::put('success','Transaction was successfuly confirmed !');
            return  Redirect::route('myTransactions');
        }
    }
    
    public function request($id){
    	
    	$payment = Payment::find($id);
    	$user = Auth::user();
    	$sid = $payment->sender->account->id;
    	
    	echo '<script>alert("WELCOME")</script>';
    	die();
    	 
    	
    	if(is_null($payment))
    		return Redirect::route('notFound');
    	if($user->id != $payment->receiver->id || $user->account_type == 'Admin' || $user->account_type == 'Sponsor')
    		return Redirect::route('permissionsDenied');
    
    	$payment->stat = 'accepted';
    	$payment->forceSave();
    
    	if($user->account_type == 'Recipient'){
    		// The recipient accepts payment from sponsor,
    		// So update next payment date for this sponsor
    		$sid = $payment->sender->account->id;
    		$date = DB::table('project_sponsor')
    		->where('sponsor_id','=',$sid)
    		->where('project_id','=',$payment->project_id)
    		->first()
    		->next_pay;
    		$date = new DateTime($date);
    		$date->modify('+1 month');
    		$date = DB::table('project_sponsor')
    		->where('sponsor_id','=',$sid)
    		->where('project_id','=',$payment->project_id)
    		->update(array('next_pay'=>$date->format('Y-m-d 00:00:00')));
    
    		// And Create a payment to coordinator from this recipient
    		$payment2 = new Payment;
    		$payment2->project_id = $payment->project_id;
    		$payment2->sender_id = $user->id;
    		$payment2->receiver_id = $payment->project->coordinator->user_id;
    		$payment2->type = "group fund";
    		$payment2->stat = "pending";
    		$payment2->save();
    		Session::put('success','Transaction was successfuly confirmed !');
    		Session::put('info','Please make sure you sent the group fund commission to coordinator !');
    		return  Redirect::route('myTransactions');
    	}else{ // So it's Coordinator !
    		Session::put('success','Transaction was successfuly confirmed !');
    		return  Redirect::route('myTransactions');
    	}
    }
    
    
    public function reject($id){
        $payment = Payment::find($id);
        $user = Auth::user();
        if(is_null($payment)) 
            return Redirect::route('notFound');
        if($user->id != $payment->receiver->id || $user->account_type == 'Admin' || $user->account_type == 'Sponsor')
            return Redirect::route('permissionsDenied');

        $payment->stat = 'rejected';
        $payment->forceSave();

        if($user->account_type == 'Recipient'){
            $coordEmail = Project::find($payment->project->id)->coordinator->user->email;
            Session::flash('cEmail',$coordEmail);
            Mail::send('emails.sponsor_payment_denied', array(
                'recipient'=>$payment->recipient,
                'sponsor'=>$payment->sponsor,
                'project'=>$payment->project
            ),function($message){
                $message->to(User::where('role_id','=',1)->first()->email)
                    ->cc(Session::get('cEmail'))
                    ->subject('Sponsorship Denied !');
            });
        }
        Session::put('error','Transaction was rejected !');
        return  Redirect::route('myTransactions');
    }

    public function add($pid,$did){
    	//echo '<script>alert('.$did.')</script>';
    	//die();
        $project = Project::find($pid);
        $user = Auth::user();
        if(is_null($project)) return Redirect::route('notFound');
        if(!$project->open){
            Session::put('error','You cannot add payment to the project "'.$project->name.'" because it is currently closed !');
            return Redirect::route('myProject');
        }
        if($user->account_type != 'Recipient' )
            return Redirect::route('permissionsDenied');

        // And Create a payment to coordinator from this recipient
        $payment2 = new Payment;
        $payment2->project_id = $pid;
        $payment2->sender_id = $user->id;
        $payment2->receiver_id = $project->coordinator->user_id;
        $payment2->type = "group fund";
        $payment2->stat = "pending";
        $payment2->save();

        return $this->save($pid,$did);
    }

    public function save($pid,$uid){
        $project = Project::find($pid);
        $user = Auth::user();
        if(is_null($project)) return Redirect::route('notFound');
        if(!$project->open){
            Session::put('error','You cannot add payment to the project "'.$project->name.'" because it is currently closed !');
            return Redirect::route('myProject');
        }
        if($user->account_type == 'Admin' || $user->account_type == 'Coordinator' || $user->account_type == 'Sponsor')
            return Redirect::route('permissionsDenied');
        
        if($user->account_type == 'Recipient'){
            $payment = new Payment;
            $payment->project_id = $pid;
            $payment->sender_id = $uid;
            $payment->receiver_id = $user->id;
            $payment->type = "sponsoring";
            $payment->stat = "accepted";
            $payment->save();
            Session::put('success','Transaction from Sponsor has been added and confirmed !');
            Session::put('info','Please make sure you sent the group fund commission to coordinator !');
        }
        // else{ // It's Sponsor
        //     $payment = new Payment;
        //     $payment->project_id = $pid;
        //     $payment->sender_id = $user->id;
        //     $payment->receiver_id = $uid;
        //     $payment->type = "sponsoring";
        //     $payment->stat = "pending";
        //     $payment->save();
        //     Session::put('success','Transaction has been added! Waiting for the recipient to confirm it.');
        // }
        return Redirect::route('myTransactions');
    }
}
