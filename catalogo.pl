% Vehicle catalog - Base facts
vehicle(toyota, rav4, suv, 28000, 2022).
vehicle(toyota, camry, sedan, 25000, 2022).
vehicle(toyota, tacoma, pickup, 35000, 2023).
vehicle(ford, mustang, sport, 45000, 2023).
vehicle(ford, explorer, suv, 38000, 2022).
vehicle(ford, f150, pickup, 42000, 2023).
vehicle(bmw, x5, suv, 60000, 2021).
vehicle(bmw, m3, sport, 65000, 2023).
vehicle(bmw, series3, sedan, 45000, 2022).
vehicle(toyota, highlander, suv, 32000, 2023).

% Basic queries and filters
meet_budget(Reference, BudgetMax) :-
    vehicle(_, Reference, _, Price, _),
    Price =< BudgetMax.

% Filter vehicles by type and maximum price
filter_by_type_price(Brand, Type, MaxPrice, Reference) :-
    vehicle(Brand, Reference, Type, Price, _),
    Price =< MaxPrice.

% Calculate total value of inventory
total_value(Type, MaxBudget, TotalValue) :-
    findall(Price, (vehicle(_, _, Type, Price, _), Price =< MaxBudget), Prices),
    sum_list(Prices, TotalValue).

% Generate report for specific brand and type within budget
generate_report(Brand, Type, Budget, Result) :-
    findall((Reference, Price, Year),
        (vehicle(Brand, Reference, Type, Price, Year), Price =< Budget),
        Result).

% Test cases

% Case 1: List all Toyota SUV references priced under $30,000
case1(Result) :-
    findall(Reference,
        (vehicle(toyota, Reference, suv, Price, _), Price < 30000),
        Result).

% Case 2: Show Ford vehicles grouped by type and year
case2(Result) :-
    bagof((Type, Year, Reference),
        (vehicle(ford, Reference, Type, _, Year)),
        Result).

% Case 3: Calculate total value of Sedan inventory under $500,000
case3(TotalValue) :-
    total_value(sedan, 500000, TotalValue).