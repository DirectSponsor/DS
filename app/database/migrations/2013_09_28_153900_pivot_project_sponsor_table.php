<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class PivotProjectSponsorTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('project_sponsor', function(Blueprint $table) {
			$table->engine = 'InnoDB';
			$table->increments('id');
			$table->integer('project_id')->unsigned()->index();
			$table->integer('sponsor_id')->unsigned()->index();
			$table->integer('recipient_id')->unsigned()->index();
			$table->timestamp('next_pay');
			$table->foreign('project_id')->references('id')->on('projects');
			$table->foreign('sponsor_id')->references('id')->on('sponsors');
			$table->foreign('recipient_id')->references('id')->on('recipients');
			$table->timestamps();
		});
	}



	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('project_sponsor');
	}

}
