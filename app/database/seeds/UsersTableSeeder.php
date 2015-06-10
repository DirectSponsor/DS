<?php

class UsersTableSeeder extends Seeder {

	public function run(){


		$users = array(
            			'username' => 'admin',
				'email' => 'admin@directsponsor.org',
				'password' => Hash::make('password'), // "pass"
				'account_type' => 'Admin'
		);

		DB::table('users')->insert($users);
	}
}
