<?php

class PaymentsTableSeeder extends Seeder {

	public function run(){

		DB::table('payments')->truncate();

		$payments = array(

		);

		DB::table('payments')->insert($payments);
	}
}
