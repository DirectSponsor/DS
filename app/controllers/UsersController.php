<?php
class UsersController extends BaseController{

    public function __construct(){
        $this->beforeFilter('auth', array('only'=> array(
            'edit','panel','logout', 'edit', 'updateEmail', 'updatePass', 'updateDetails', 'permissionsDenied', 'visitorOnly', 'notFound'
        )));
    }

    public function loginForm(){ // Shows the login page
        if(Auth::check())
            return Redirect::route('panel');
        $this->layout = 'layouts.login';
        $this->render('users.login');
    }
    public function loginAction(){ // Login the user
        $credentials = array(
            'username' => Input::get('username'),
            'password' => Input::get('password')
        );
        
        if(Auth::attempt($credentials)){
            $accountType = Auth::user()->account_type;
            if($accountType == 'Recipient'){
                $recipient = Auth::user()->account;
                if(!$recipient->confirmed){
                    Auth::logout();
                    Session::put('info','You have to confirm your email before login to your account. Please check your email inbox !');
                    return Redirect::route('login.form');
                }
            }
            if($accountType == 'Sponsor'){
                $sponsor = Auth::user()->account;
                if(!$sponsor->confirmed){
                    Auth::logout();
                    Session::put('info','You have to confirm your email before login to your account. Please check your email inbox !');
                    return Redirect::route('login.form');
                }elseif($sponsor->suspended){
                    Auth::logout();
                    Session::put('info','Your account is suspended now !');
                    return Redirect::route('login.form');
                }
            }
            return Redirect::route('panel');
        }else{
            Session::put('error','Incorrect Username or Password!');
            return Redirect::route('login.form');
        }
    }

    public function logout(){
        Auth::logout();
        return Redirect::route('login.form');
    }

    public function resendConfEmailForm(){
        $this->layout = 'layouts.resend-conf-email';
        $this->render('users.resend-conf-email');
    }

    public function resendConfEmailAction(){
        $email = Input::get('username');
        $user = User::where('email', '=', $email)->first();
        if(!is_null($user) &&  $user->account_type == 'Sponsor' && $user->account->confirmed == 0){
            Session::flash('email',$user->email);
            //send email
            $project = $user->account->projects->first();
            Mail::send('emails.sponsors.confirmation', array(
                'name' => $user->account->name,
                'hash' => Hash::encrypt($user->account->id),
                'project' => $project,
                'recipientSkrill' => $user->account->recipientOfProject($project->id)->skrill_acc
            ), function($message){
                $message->to(Input::get('username'))->subject('Sponsor account created (Copy) !');
            });
            Session::put('success','A confirmation email was sent to your email ' . $user->email);
            return Redirect::route('users.resendConfEmailForm');
        }else{
            Session::put('error','Such email do not exist !');
            return Redirect::route('users.resendConfEmailForm');
        }
    }

    public function forgetPasswordForm(){
        $this->layout = 'layouts.forget-password';
        $this->render('users.forget-password');
    }

    public function forgetPasswordAction(){
        $credentials = array('email' => Input::get('email'));
        return Password::remind($credentials, function($message, $user){
            $message->subject('Your Password Reminder');
        });
    }

    public function forgetPasswordConfirmForm($token){
        $this->layout = 'layouts.forget-password-confirm';
        $this->render('users.forget-password-confirm', false, array('token'=>$token));
    }

    public function forgetPasswordConfirmAction($token){
        $credentials = array(
            'email' => Input::get('email'),
            'password' => Input::get('password'),
            'password_confirmation' => Input::get('password_confirmation')
        );

        return Password::reset($credentials, function($user, $password)
        {
            $user->password = Hash::make($password);
            $user->save();
            Session::put('success','Password successfully updated');
            return Redirect::route('login.form');
        });
    }

    public function panel(){
        $user = Auth::user();
        switch($user->account_type){
            case 'Admin': 
                return Redirect::route('projects.index');
            break;
            case 'Coordinator': 
                return Redirect::route('myProject');
            break;
            case 'Recipient': 
                return Redirect::route('myProject');
            break;
            case 'Sponsor': 
                return Redirect::route('myProject');
            break;
        }
    }

    public function edit($id){
        if(Auth::user()->account_type == 'Admin')
            $profile = null;
        else
            $profile = Auth::user()->account;
        $this->render('users.edit','Edit Account Details',array(
            'user' => Auth::user(),
            'profile' => $profile
        ));
    }

    public function updateEmail($id){
        $userId = Auth::user()->id;
        if($userId != $id){
            return Redirect::route('permissionsDenied');
        }
        $user = User::find($id);
        User::$rules = array('email' => 'required|email|unique:users,email,'.$id);
        $user->setFillable(array('email'));
        
        Recipient::$rules = array('skrill_acc' => 'required|email|unique:recipients,skrill_acc,'.$id);
		        
                
        if(!Hash::check(Input::get('current_password'),$user->password)){
            Session::put('error','The password you entered was not correct !');
            return Redirect::route('users.edit',$id)->withInput();
        }
        
        if(!$user->save()){
            Session::put('error','There were some errors !');
            return Redirect::route('users.edit',$id)->withErrors($user->errors())->withInput();
        }
        Session::put('success','Your email was modified !');
        return Redirect::route('users.edit',$id);
    }

    public function updatePass($id){
        $userId = Auth::user()->id;
        if($userId != $id){
            return Redirect::route('permissionsDenied');
        }
        $user = User::find($id);
        User::$rules = array('password' => 'required|min:6');
        $user->setFillable(array('password'));

        if(!Hash::check(Input::get('current_password'),$user->password)){
            Session::put('error','The password you entered was not correct !');
            return Redirect::route('users.edit',$id)->withInput();
        }
        
        if(Input::get('password') != Input::get('password_confirmation')){
            Session::put('error','The password confirmation does not match !');
            return Redirect::route('users.edit',$id)->withInput();
        }
        
        if(!$user->save()){
            Session::put('error','There was some errors !');
            return Redirect::route('users.edit',$id)->withErrors($user->errors())->withInput();
        }
        Session::put('success','Your password was modified !');
        return Redirect::route('users.edit',$id);
    }

    public function updateDetails($id){
        $accountType = Auth::user()->account_type;
        $userId = Auth::user()->id;
        if($userId != $id){
            return Redirect::route('permissionsDenied');
        }
        $user = User::find($id);
        $account = $user->account;
        if(!Hash::check(Input::get('current_password'),$user->password)){
            Session::put('error','The password you entered was not correct !');
            return Redirect::route('users.edit',$id)->withInput();
        }
        
        Recipient::$rules = array('skrill_acc' => 'required|email|unique:recipients,skrill_acc,'.$account->id);
        Sponsor::$rules = array('skrill_acc' => 'required|email|unique:recipients,skrill_acc,'.$account->id);
        if(!$account->save()){
            Session::put('error','There was some errors !');
            return Redirect::route('users.edit',$id)->withErrors($account->errors())->withInput();
        }
        Session::put('success','Your details was modified !');
        return Redirect::route('users.edit',$id);
    }

    public function permissionsDenied(){
        $this->render('static.permissions_denied');
    }
    public function visitorOnly(){
        $this->render('static.visitor_only');
    }
    public function notFound(){
        $this->render('static.not_found');
    }
}
