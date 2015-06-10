<?php

class DatabaseSeeder extends Seeder {

	/**
	 * Run the database seeds.
	 *
	 * @return void
	 */
	public function run()
	{
		Eloquent::unguard();

		// $this->call('SpendsTableSeeder');
		// $this->call('ProjectsTableSeeder');
		$this->call('UsersTableSeeder');
		// $this->call('CoordinatorsTableSeeder');
		// $this->call('RecipientsTableSeeder');
		// $this->call('SponsorsTableSeeder');
		// $this->call('InvitationsTableSeeder');
		// $this->call('PaymentsTableSeeder');
		// $this->call('SettingsTableSeeder');
	}

}