# Mercadoni

This gem will help Mercadoni's developers. 

## Installation

Install it yourself as:

    $ gem install mercadoni

## Usage

#### Deploy a Mercadoni's APP:

1) Ask for the AWS credentials (MERCADONI_AWS_KEY, MERCADONI_AWS_SECRET) which you must set up locally:
2) Ask for the ssh private key that is used to loggin on Mercadoni's servers as app user.
3) You must ensure that you're on master (production) or dev (development) branch before deploying. Then, you can execute the command shown below.


    $ mercadoni <app_name>

Possible app names:

| Production | Development |
|------------|-------------|
| client     | client-dev  |
| admin      | admin-dev   |
| shopper    | shopper-dev |
| catalog    | catalog-dev |
| socket     | socket-dev  |
| partner    | partner-dev |
| bi (dev)   | bi-dev      |

** You can deploy multiple apps like this:

    $ mercadoni <app_name> <app_name> <app_name>


#### See Mercadoni's APP logs:

1) Ask for the ssh private key that is used to loggin on Mercadoni's servers as app user.
2) Execute the command shown below


    $ mercadoni <app_name> --logs


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Created by Sebastian Vizcaino
