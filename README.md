# airbnb-dbt-snowflake-pipeline
End-to-end Medallion Data Engineering pipeline


# 🏠 Airbnb Data Transformation Pipeline (dbt + Snowflake)

An enterprise-grade Data Transformation pipeline implementing **Medallion Architecture**, **SCD Type 2 Snapshots**, and **Metadata-Driven Joins** built with **dbt Core** and **Snowflake**.

---

## 🏗️ Architecture & Data Lineage
<img width="1401" height="237" alt="Screenshot 2026-10-20 at 4 32 07 PM" src="https://github.com/user-attachments/assets/6490b447-a8fd-40e9-bc3f-c344c3d01627" />

```mermaid
flowchart LR
    subgraph Staging ["Raw Sources (Snowflake)"]
        S1[(bookings)]
        S2[(listings)]
        S3[(hosts)]
    end

    subgraph Bronze ["Bronze Layer (Incremental Raw Tables)"]
        B1[bronze_bookings]
        B2[bronze_listings]
        B3[bronze_hosts]
    end

    subgraph Silver ["Silver Layer (Cleansed & Enriched)"]
        S_B[silver_bookings]
        S_L[silver_listings]
        S_H[silver_hosts]
    end

    subgraph Gold ["Gold Layer (Analytics & Dimensional Modeling)"]
        OBT[obt (One Big Table)]
        FACT[fact]
        E_B[ephemeral_bookings]
        E_L[ephemeral_listings]
        E_H[ephemeral_hosts]
    end

    subgraph Snapshots ["Snapshots (SCD Type 2)"]
        SNAP_B[dim_bookings]
        SNAP_L[dim_listings]
        SNAP_H[dim_hosts]
    end

    S1 --> B1 --> S_B --> OBT
    S2 --> B2 --> S_L --> OBT
    S3 --> B3 --> S_H --> OBT

    OBT --> FACT
    OBT --> E_B --> SNAP_B
    OBT --> E_L --> SNAP_L
    OBT --> E_H --> SNAP_H


1. Medallion Architecture

Bronze Layer: Incremental ingestion from staging sources with dynamic watermark tracking (created_at) and audit columns (_loaded_at).

Silver Layer: Data cleansing and business transformations:
Custom Jinja Macro {{ multiply(...) }} for accurate total amounts.
Custom String Cleansing {{ trimmer(...) }} and case transforms (replace()).
Tier categorization with {{ tag(...) }}.
Automatic schema isolation (AIRBNB.SILVER) via custom generate_schema_name macro.

Gold Layer:
Metadata-Driven OBT (One Big Table): Uses Jinja configurations and dynamic LEFT JOIN generation to eliminate repetitive boilerplate.
Star Schema: Modular dimensional architecture feeding fact and dimension tables.


2. Slow Changing Dimensions (SCD Type 2)
Implemented dbt Snapshots (dim_bookings, dim_listings, dim_hosts) to track historical attribute changes over time using timestamp strategy with dbt_valid_to_current = '9999-12-31'.


3. Data Quality & Testing
Custom singular tests in tests/source_tests.sql validating fee bounds (booking_amount, cleaning_fee, service_fee >= 0) with configurable alerting (severity = 'warn').

🛠️ Tech Stack
Data Warehouse: Snowflake
Transformation Engine: dbt Core (v1.12)
Adapter: dbt-snowflake
Environment Management: uv + Python 3.12
Language: SQL, Jinja
