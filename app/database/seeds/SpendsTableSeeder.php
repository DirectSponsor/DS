<?php

class SpendsTableSeeder extends Seeder {

	public function run(){

		DB::table('spends')->truncate();

		$spends = array(

		);

		DB::table('spends')->insert($spends);
	}
}
