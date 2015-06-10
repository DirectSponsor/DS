<?php

class ProjectsTableSeeder extends Seeder {

	public function run(){

		DB::table('projects')->truncate();

		$projects = array(

		);

		DB::table('projects')->insert($projects);
	}
}
