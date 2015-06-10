<p class="info"> Please confirm that you sent payment with the following informations: </p>
<div class="infos">
    <p class="field"> Destination Skrill Account: </p><p class="value">{{ $recipientSkrill }}</p><div class="clear"></div>
    <p class="field"> Amount: </p><p class="value">{{ $project->amount }} {{$project->currency}} ( approx {{$project->euro_amount}} EUR ) </p><div class="clear"></div>
</div>
{{ Form::open(array('route'=>array('payments.save',array($project->id,$uid))))
    Form::submit('I Confirm'), Form::close() }}