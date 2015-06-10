<?php

/*
|--------------------------------------------------------------------------
| Register The Laravel Class Loader
|--------------------------------------------------------------------------
|
| In addition to using Composer, you may use the Laravel class loader to
| load your controllers and models. This is useful for keeping all of
| your classes in the "global" namespace without Composer updating.
|
*/

ClassLoader::addDirectories(array(

    app_path().'/commands',
    app_path().'/controllers',
    app_path().'/models',
    app_path().'/database/seeds',

));

/*
|--------------------------------------------------------------------------
| Application Error Logger
|--------------------------------------------------------------------------
|
| Here we will configure the error logger setup for the application which
| is built on top of the wonderful Monolog library. By default we will
| build a rotating log file setup which creates a new file each day.
|
*/

$logFile = 'log-'.php_sapi_name().'.txt';

Log::useDailyFiles(storage_path().'/logs/'.$logFile);

/*
|--------------------------------------------------------------------------
| Application Error Handler
|--------------------------------------------------------------------------
|
| Here you may handle any errors that occur in your application, including
| logging them or displaying custom views for specific errors. You may
| even register several error handlers to handle different types of
| exceptions. If nothing is returned, the default error view is
| shown, which includes a detailed stack trace during debug.
|
*/

App::error(function(Exception $exception, $code)
{
    Log::error($exception);
});

/*
|--------------------------------------------------------------------------
| Maintenance Mode Handler
|--------------------------------------------------------------------------
|
| The "down" Artisan command gives you the ability to put an application
| into maintenance mode. Here, you will define what is displayed back
| to the user if maintenace mode is in effect for this application.
|
*/

App::down(function()
{
    return Response::make("Be right back!", 503);
});

/*
|--------------------------------------------------------------------------
| Require The Filters File
|--------------------------------------------------------------------------
|
| Next we will load the filters file for the application. This gives us
| a nice separate location to store our route and application filter
| definitions instead of putting them all in the main routes file.
|
*/

require app_path().'/filters.php';

/* Views Composers */
// Navigation
View::composer('layouts.elements.nav', function($view){
    $links = array();
    if(Auth::check()){
        $user = Auth::user();
        $accountType = $user->account_type;
        switch($accountType){
            case 'Admin':
                $links = array(
                    array(
                        'name' => 'Projects',
                        'link' => URL::route('projects.index'),
                        'page' =>'projects'
                    ),
                    array(
                        'name' => 'Coordinators',
                        'link' => URL::route('coordinators.index'),
                        'page' =>'cordinators'
                    ),
                    array(
                        'name' => 'Recipients',
                        'link' => URL::route('recipients.index'),
                        'page' =>'recipients'
                    ),
                    array(
                        'name' => 'Sponsors',
                        'link' => URL::route('sponsors.index'),
                        'page' =>'sponsors'
                    ),
                    array(
                        'name' => 'My Account',
                        'link' => URL::route('users.edit',$user->id),
                        'page' =>'myaccount'
                    ),
                    array(
                        'name' => 'Logout',
                        'link' => URL::route('logout'),
                        'page' =>'logout'
                    )
                );
            break;
            case 'Coordinator' :
                $links = array(
                    array(
                        'name' => 'My Project',
                        'link' => URL::route('myProject'),
                        'page' =>'myproject'
                    ),
                    array(
                        'name' => 'Recipients',
                        'link' => URL::route('myRecipients'),
                        'page' =>'recipients'
                    ),
                    array(
                        'name' => 'Invitations',
                        'link' => URL::route('projects.invitations.index',$user->account->project_id),
                        'page' =>'invitations'
                    ),
                    array(
                        'name' => 'Sponsors',
                        'link' => URL::route('mySponsors'),
                        'page' =>'sponsors'
                    ),
                    array(
                        'name' => 'Transactions',
                        'link' => URL::route('myTransactions'),
                        'page' =>'transactions'
                        
                    ),
                    array(
                        'name' => 'Activities',
                        'link' => URL::route('myActivities'),
                        'page' =>'activities'
                    ),
                    array(
                        'name' => 'My Account',
                        'link' => URL::route('users.edit',$user->id),
                        'page' =>'myaccount'
                    ),
                    array(
                        'name' => 'Logout',
                        'link' => URL::route('logout'),
                        'page' =>'logout'
                    )
                );
            break;
            case 'Recipient' :
                $links = array(
                    array(
                        'name' => 'My Project',
                        'link' => URL::route('myProject'),
                        'page' =>'myproject'
                    ),
                    array(
                        'name' => 'Sponsors',
                        'link' => URL::route('mySponsors'),
                        'page' =>'sponors'
                    ),
                    array(
                        'name' => 'Transactions',
                        'link' => URL::route('myTransactions'),
                        'page' =>'transactions'
                    ),
                    array(
                        'name' => 'My Account',
                        'link' => URL::route('users.edit',$user->id),
                        'page' =>'myaccount'
                    ),
                    array(
                        'name' => 'Logout',
                        'link' => URL::route('logout'),
                        'page' =>'logout'
                    )
                );
            break;
            case 'Sponsor' :
                $links = array(
                    array(
                        'name' => 'Projects',
                        'link' => URL::route('myProject'),
                        'page' =>'projects'
                    ),
                    array(
                        'name' => 'Transactions',
                        'link' => URL::route('myTransactions'),
                        'page' =>'transactions'
                    ),
                    array(
                        'name' => 'Join Project',
                        'link' => URL::route('joinProject'),
                        'page' =>'joinproject'
                    ),
                    array(
                        'name' => 'My Account',
                        'link' => URL::route('users.edit',$user->id),
                        'page' =>'myaccount'
                    ),
                    array(
                        'name' => 'Logout',
                        'link' => URL::route('logout'),
                        'page' =>'logout'
                    )
                );
            break;
        }
    }
    $view->with('links',$links);
});

/** Config Encrypting KEY **/
Hash::setEncryptKey('directsponsor');
