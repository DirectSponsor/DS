<?php

class InvitationsTableSeeder extends Seeder {

	public function run(){

		DB::table('invitations')->truncate();

		$invitations = array(

		);

		DB::table('invitations')->insert($invitations);
	}
}
