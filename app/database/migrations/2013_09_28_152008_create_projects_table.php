<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateProjectsTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('projects', function(Blueprint $table) {
			$table->engine = 'InnoDB';
			$table->increments('id');
			$table->string('name');
			$table->string('url')->unique()->index();
			$table->text('content');
			$table->integer('max_recipients');
			$table->integer('max_sponsors_per_recipient');
			$table->string('currency');
			$table->decimal('amount');
			$table->decimal('euro_amount');
			$table->decimal('gf_commission');
			$table->boolean('open')->index();
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
		Schema::drop('projects');
	}

}
