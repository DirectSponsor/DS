<?php

class CoordinatorsTableSeeder extends Seeder {

	public function run(){

		DB::table('coordinators')->truncate();

		$coordinators = array(

		);

		DB::table('coordinators')->insert($coordinators);
	}
}
