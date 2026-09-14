<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            CurrencySeeder::class,
            LanguageSeeder::class,
            SiteSettingsSeeder::class,
            ThemeSeeder::class,
            AdminSeeder::class,
            CategorySeeder::class,
            BrandSeeder::class,
            AttributeSeeder::class,
            ProductSeeder::class,
            BannerSeeder::class,
            MenuSeeder::class,
            PaymentGatewaySeeder::class,
            PaymentGatewayConfigSeeder::class,
            OrderSeeder::class,
            PaymentSeeder::class,
            RefundSeeder::class,
        ]);
    }
}