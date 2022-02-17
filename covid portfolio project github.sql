select * from [PORTFOLIO PROJECT]..DEATHS order by 3,4
--select * from [PORTFOLIO PROJECT]..VAC order by 3,4

select location, date, total_cases ,new_cases ,total_deaths, population
from [PORTFOLIO PROJECT]..DEATHS
order by 1,2

--total cases vs total deaths(�խY�P�V�����v)

select location, date,  total_cases ,total_deaths ,(total_deaths/total_cases)*100 as ���`�v
from [PORTFOLIO PROJECT]..DEATHS
where location like '%aiwan%'

--�`�H�f���h�֤H�P�V�߫a

select location, date,  total_cases ,population ,(total_cases /population)*100 as �P�V�v
from [PORTFOLIO PROJECT]..DEATHS

--�U��P�V�v(time:2022-02-07)

SELECT location, total_cases,population ,(total_cases/population)*100 as �P�V�v
from [PORTFOLIO PROJECT]..DEATHS
where  date='2022-02-07 00:00:00.000'
order by 4 desc

--�U�ꦺ�`�v(time:2022-02-07)

select location, population , total_deaths, (total_deaths/population)*100 as ���`�v
from [PORTFOLIO PROJECT]..DEATHS
where  date='2022-02-07 00:00:00.000'
and continent is not null
order by 4 desc

--�U�w���
select location,population , total_cases ,total_deaths , (total_deaths/population)*100 as  ���`�v ,
(total_cases/population)*100 as �P�V�v
from [PORTFOLIO PROJECT]..DEATHS
where continent is  null 
and   date='2022-02-07 00:00:00.000'
order by 5,6 desc
  
--���y�έp

select  date, sum(new_cases) as 'total cases',sum (cast (new_deaths as int)) as 'total deaths'
 , (sum (cast (new_deaths as int))/sum(new_cases))*100 as ���`�v
from [PORTFOLIO PROJECT]..DEATHS
where continent is not null 
group by date
order by 1,2

--total cases, total deaths, ���`�v

select sum(new_cases) as 'total cases' , sum(cast(new_deaths as int) ) as 'total deaths', 
 (sum(cast(new_deaths as int) )/sum(new_cases))*100 as '���`�v'
from [PORTFOLIO PROJECT]..DEATHS
where continent is not null 

--���G     total cases :395858666 / total deaths : 5724305 / ���`�v : 1.44604766591115 percent

--vaccination part


--�U��h�֤H���F�̭]

select vac.location,vac.date ,dea.population , vac.people_vaccinated , 
 ( vac.people_vaccinated/dea.population)*100 as �̭]�л\�v
from [PORTFOLIO PROJECT]..VAC vac
join [PORTFOLIO PROJECT]..DEATHS dea
on vac.location=dea.location and vac.date=dea.date
where vac.date = '2022-02-07 00:00:00.000' and vac.continent is not null

--�x�W�̭]�л\�v�ܤ�
select vac.location,vac.date ,dea.population , vac.people_vaccinated ,
 ( vac.people_vaccinated/dea.population)*100 as �̭]�л\�v, vac.people_fully_vaccinated,
 ( vac.people_fully_vaccinated/dea.population)*100 as ����̭]�л\�v
from [PORTFOLIO PROJECT]..VAC vac
join [PORTFOLIO PROJECT]..DEATHS dea
on vac.location=dea.location and vac.date=dea.date
where vac.location='Taiwan'
order by vac.date desc

