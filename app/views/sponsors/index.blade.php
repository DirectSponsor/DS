<?php $accountType = Auth::user()->account_type; ?>
@if(count($sponsors)) <table class="data"> @else <table> @endif
    <thead><tr>
        <th>Join date</th>
        <th>Username</th>
        <th>Skrill Account</th>
        <th>Projects Number</th>
        <th></th>
    </tr></thead>
    <tbody>
    @if(!count($sponsors))
    <tr>
        <td colspan="5"><p>There are no sponsors yet ! </p></td>
    </tr>
    @endif
    @foreach($sponsors as $sponsor)
    <tr>
        <td>{{$sponsor->created_at}}</td>
        <td>{{$sponsor->user->username}}</td>
        <td>{{$sponsor->skrill_acc}}</td>
        <td>{{$sponsor->projects->count()}}</td>
        <td> @if($accountType == 'Admin')
            <a href="{{URL::route('sponsors.projects',$sponsor->id)}}" class="red_button">Suspend</a>
        @endif
        @if($accountType == 'Recipient')
            <!--  <a href="{{URL::route('payments.add',array(Auth::user()->account->project_id,$sponsor->user_id))}}">Add Payment</a>-->
        @endif </td>
    </tr>
    @endforeach
</tbody></table>