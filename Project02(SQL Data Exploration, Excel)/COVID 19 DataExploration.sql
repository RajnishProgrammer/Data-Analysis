/*
This is the project on Data Exploration of global COVID 19 Data.
Here I am explore the data that I have in excel data sheet format.
Before importing this data on SSMS I had to some changes to in datasheet 
according to my requirements. like deleting some columns that i didn't have to use.
*/

-- Viewing covid deaths sorted by date
select * 
from DataAnalysis..CovidDeaths
order by 3,4

-- Viewing covid vaccinations according to date
select * 
from DataAnalysis..CovidVaccinations
order by 3,4


select location,date,total_cases, new_cases, total_deaths, population
from DataAnalysis..CovidDeaths
order by 1,2

 -- calculating death percentage for united states
select location,date,total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from DataAnalysis..CovidDeaths
where location like '%states%'
order by 1,2

-- calculating covid spreading rate for states
select location,date,total_cases, population, (total_cases/population)*100 as CovidPercentage
from DataAnalysis..CovidDeaths
where location like '%states%'
order by 1,2

-- calculating TotalDeath for each location or country
select location,max(cast(total_deaths as int))as TotalDeathCount
from DataAnalysis..CovidDeaths
---where location like '%states%'
where continent is not null
group by location
order by TotalDeathCount desc

-- Calculating total_new_deaths
select location,sum(cast(new_deaths as int))as TotalNewDeathCount
from DataAnalysis..CovidDeaths
---where location like '%states%'
where continent is null
and location not in ('World', 'European Union', 'International', 'High income', 'Low income', 'Upper middle income', 'Lower middle income')
group by location
order by TotalNewDeathCount desc

--************************** calculating death percentage on the basis of new cases************************
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths,sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from DataAnalysis..CovidDeaths
where continent is not null
order by 1,2

-- Calculating highest infection count with percent population infected
select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
from DataAnalysis..CovidDeaths
group by location, population
order by PercentPopulationInfected desc 

select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
from DataAnalysis..CovidDeaths
where continent is null
and location not in ('World', 'European Union', 'International', 'High income', 'Low income', 'Upper middle income', 'Lower middle income')
group by location, population
order by PercentPopulationInfected desc 

select location, population,date, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
from DataAnalysis..CovidDeaths
group by location, population,date
order by PercentPopulationInfected desc

--> Joining the tables and show new_vaccinations and number of people vaccinating
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from DataAnalysis..CovidDeaths dea
join DataAnalysis..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3


---> use cte's
with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from DataAnalysis..CovidDeaths dea
join DataAnalysis..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
---order by 2,3
)
select * ,(RollingPeopleVccinated/Population)*100 as PercentageRollingPeopleVccinated
from PopvsVac


---Temp Table
drop table if exists #PercentPopulationVaccinated 
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)
insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from DataAnalysis..CovidDeaths dea
join DataAnalysis..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
---where dea.continent is not null
---order by 2,3

select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated


--Creating View
create view PercentPopulationVaccinated as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from DataAnalysis..CovidDeaths dea
join DataAnalysis..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select * , (RollingPeopleVaccinated/Population)*100
from PercentPopulationVaccinated

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------