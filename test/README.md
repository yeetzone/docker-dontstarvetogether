# Test Suite

## How to run the tests
```sh
./run.sh
```

### How to run a specific test or tests
```sh
./run.sh <test_name>...
```

## How to write a tests
You must create a directory inside this and add a `run.sh` script to check whatever you want. Things
to have in mind:
* You are going to be called with the name of the image in `$1`.
* You can create all the containers and volumes that you want, but you must be sure to delete all of
them before you leave the script.
* If the test pass you must exit with a `0` otherwise with something different of `0`
