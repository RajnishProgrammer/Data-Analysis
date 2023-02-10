/*
NashvilleHousing Data
Cleaning Data in SQL Queries
*/

Select *
From DataAnalysis.dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

Select SaleDateConverted, CONVERT(Date,[Sale Date])
From DataAnalysis.dbo.NashvilleHousing


Update NashvilleHousing
SET [Sale Date] = CONVERT(Date,[Sale Date])

-- If it doesn't Update properly

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,[Sale Date])


 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select *
From DataAnalysis.dbo.NashvilleHousing
---Where [Property Address] is null
order by [Parcel ID]

Select a.[Parcel ID], a.[Property Address], b.[Parcel ID], b.[Property Address], ISNULL(a.[Property Address],b.[Property Address])
From DataAnalysis.dbo.NashvilleHousing a
JOIN DataAnalysis.dbo.NashvilleHousing b
	on a.[Parcel ID] = b.[Parcel ID]
	AND a.[Unnamed: 0] <> b.[Unnamed: 0] 
Where a.[Property Address] is null

Update a
SET [Property Address] = ISNULL(a.[Property Address],'No Address')
From DataAnalysis.dbo.NashvilleHousing a
JOIN DataAnalysis.dbo.NashvilleHousing b
	on a.[Parcel ID] = b.[Parcel ID]
	AND a.[Unnamed: 0]  <> b.[Unnamed: 0] 
Where a.[Property Address] is null

--------------------------------------------------------------------------------------------------------------------------

-- checking property address column

Select [Property Address]
From DataAnalysis.dbo.NashvilleHousing
Where [Property Address] is null
order by [Parcel ID]

--------------------------------------------------------------------------------------------------------------------------

-- checking sold as vacant column

Select Distinct([Sold As Vacant]), Count([Sold As Vacant])
From DataAnalysis.dbo.NashvilleHousing
Group by [Sold As Vacant]
order by 2

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY [Parcel ID],
				 [Property Address],
				 [Sale Price],
				 [Sale Date],
				 [Legal Reference]
				 ORDER BY
					[Unnamed: 0]
					) row_num

From DataAnalysis.dbo.NashvilleHousing
--order by [Parcel ID]
)
select *
From RowNumCTE
Where row_num > 1
---Order by [Property Address]



Select *
From DataAnalysis.dbo.NashvilleHousing

---renaming the column name
use DataAnalysis
exec sp_rename '[dbo].[NashvilleHousing]."[Unique ID]"', 'Unique ID', 'Column';

---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

Select *
From DataAnalysis.dbo.NashvilleHousing


ALTER TABLE DataAnalysis.dbo.NashvilleHousing
DROP COLUMN [Sale Date]

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
