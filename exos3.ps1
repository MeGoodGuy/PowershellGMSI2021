


$UserList = @(
    @{ ID=1; Name="AAA" },
    @{ ID=2; Name="BBB" },
    @{ ID=3; Name="CCC" },
    @{ ID=4; Name="DDD" },
    @{ ID=5; Name="EEE" },
    @{ ID=6; Name="FFF" }
)


$UserList | ForEach-Object -Parallel

