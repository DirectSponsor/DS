<?php

class RecipientsTableSeeder extends Seeder {

	public function run(){

		DB::table('recipients')->truncate();

		$recipients = array(

		);

		DB::table('recipients')->insert($recipients);
	}
}
