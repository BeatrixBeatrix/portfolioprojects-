select * from [PORTFOLIO PROJECT]..DEATHS order by 3,4
--select * from [PORTFOLIO PROJECT]..VAC order by 3,4

select location, date, total_cases ,new_cases ,total_deaths, population
from [PORTFOLIO PROJECT]..DEATHS
order by 1,2

--total cases vs total deaths(倘若感染的死率)

select location, date,  total_cases ,total_deaths ,(total_deaths/total_cases)*100 as 死亡率
from [PORTFOLIO PROJECT]..DEATHS
where location like '%aiwan%'

--總人口中多少人感染心冠

select location, date,  total_cases ,population ,(total_cases /population)*100 as 感染率
from [PORTFOLIO PROJECT]..DEATHS

--各國感染率(time:2022-02-07)

SELECT location, total_cases,population ,(total_cases/population)*100 as 感染率
from [PORTFOLIO PROJECT]..DEATHS
where  date='2022-02-07 00:00:00.000'
order by 4 desc

--各國死亡率(time:2022-02-07)

select location, population , total_deaths, (total_deaths/population)*100 as 死亡率
from [PORTFOLIO PROJECT]..DEATHS
where  date='2022-02-07 00:00:00.000'
and continent is not null
order by 4 desc

--各洲資料
select location,population , total_cases ,total_deaths , (total_deaths/population)*100 as  死亡率 ,
(total_cases/population)*100 as 感染率
from [PORTFOLIO PROJECT]..DEATHS
where continent is  null 
and   date='2022-02-07 00:00:00.000'
order by 5,6 desc
  
--全球統計

select  date, sum(new_cases) as 'total cases',sum (cast (new_deaths as int)) as 'total deaths'
 , (sum (cast (new_deaths as int))/sum(new_cases))*100 as 死亡率
from [PORTFOLIO PROJECT]..DEATHS
where continent is not null 
group by date
order by 1,2

--total cases, total deaths, 死亡率

select sum(new_cases) as 'total cases' , sum(cast(new_deaths as int) ) as 'total deaths', 
 (sum(cast(new_deaths as int) )/sum(new_cases))*100 as '死亡率'
from [PORTFOLIO PROJECT]..DEATHS
where continent is not null 

--結果     total cases :395858666 / total deaths : 5724305 / 死亡率 : 1.44604766591115 percent

--vaccination part


--各國多少人打了疫苗

select vac.location,vac.date ,dea.population , vac.people_vaccinated , 
 ( vac.people_vaccinated/dea.population)*100 as 疫苗覆蓋率
from [PORTFOLIO PROJECT]..VAC vac
join [PORTFOLIO PROJECT]..DEATHS dea
on vac.location=dea.location and vac.date=dea.date
where vac.date = '2022-02-07 00:00:00.000' and vac.continent is not null

--台灣疫苗覆蓋率變化
select vac.location,vac.date ,dea.population , vac.people_vaccinated ,
 ( vac.people_vaccinated/dea.population)*100 as 疫苗覆蓋率, vac.people_fully_vaccinated,
 ( vac.people_fully_vaccinated/dea.population)*100 as 完整疫苗覆蓋率
from [PORTFOLIO PROJECT]..VAC vac
join [PORTFOLIO PROJECT]..DEATHS dea
on vac.location=dea.location and vac.date=dea.date
where vac.location='Taiwan'
order by vac.date desc

