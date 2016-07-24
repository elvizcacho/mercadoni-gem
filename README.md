# Mercadoni

This gem will help Mercadoni's developers. 

## Installation

Install it yourself as:

    $ gem install mercadoni

## Usage

#### Deploy a Mercadoni's APP:

You must ensure that you're on master (production) or dev (development) branch before deploying. Then, you can execute the command shown below.

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

    $ mercadoni <app_name> --logs


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Created by Sebastian Vizcaino
