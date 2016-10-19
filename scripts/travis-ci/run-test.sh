#!/bin/bash

# Run either PHPUnit tests or PHP_CodeSniffer tests on Travis CI, depending
# on the passed in parameter.

case "$1" in
    PHP_CodeSniffer)
        cd $MODULE_DIR
        composer install
        ./vendor/bin/phpcs
        exit $?
        ;;
    *)
        ln -s $MODULE_DIR $DRUPAL_DIR/modules/og
        cd $DRUPAL_DIR
        ./vendor/bin/phpunit -c ./core/phpunit.xml.dist $DRUPAL_DIR/core/modules/field/src/Tests/EntityReference/EntityReferenceFieldDefaultValueTest.php
        
        ./vendor/bin/phpunit -c ./core/phpunit.xml.dist $MODULE_DIR/tests/src/Functional/OgSelectionConfigurationFormTest.php
        exit $?
esac
