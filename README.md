![Banner](https://raw.githubusercontent.com/doublethreedigital/addon-boilerplate/master/banner.png)

## Addon Boilerplate

This repository contains the source code for :addonName. :addonName is a commercial addon, to use it in production, you'll need to [purchase a license](https://statamic.com/:marketplaceSlug).

## Installation

1. Install via Composer `composer require :vendorName/:packageName`
2. Publish configuration, assets etc `php artisan vendor:publish --provider=":vendorName/:addonName"`

## Documentation

### Configuration

This addon provides its own configuration file. You can use this to configure the API keys and other options.

```php
return [
    //
];
```

### Replacing everything

Here's a breif list of strings that you'll need to swap out with your own.

* `:vendorName`
* `:packageName`
* `:marketplaceSlug`
* `doublethreedigital`
* `addon-boilerplate`

## Security

From a security perspective, only the latest version will receive a security release if a vulnerability is found.

If you discover a security vulnerability within :addonName, please report it [via email](mailto::vendorEmail) straight away. Please don't report security issues in the issue tracker.

## Resources

* [**Issue Tracker**](https://github.com/:vendorName/:addonName/issues): Find & report bugs in :addonName
* [**Discussions**](https://github.com/:vendorName/:addonName/discussions): Get help and put forward feature requests
* [**Email**](mailto::vendorEmail): Support from the developer behind the addon

---

<p>
<a href="https://statamic.com"><img src="https://img.shields.io/badge/Statamic-3.0+-FF269E?style=for-the-badge" alt="Compatible with Statamic v3"></a>
<a href="https://packagist.org/packages/:vendorName/:addonName/stats"><img src="https://img.shields.io/packagist/v/:vendorName/:addonName?style=for-the-badge" alt=":addonName on Packagist"></a>
</p>
