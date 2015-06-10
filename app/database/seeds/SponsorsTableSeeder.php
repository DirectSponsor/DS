<?php

class SponsorsTableSeeder extends Seeder {

	public function run(){

		DB::table('sponsors')->truncate();

		$sponsors = array(

		);

		DB::table('sponsors')->insert($sponsors);
	}
}
