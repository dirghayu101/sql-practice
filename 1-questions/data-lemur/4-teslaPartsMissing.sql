-- Question Link: https://datalemur.com/questions/tesla-unfinished-parts

-- My solution
SELECT part, assembly_step FROM parts_assembly
EXCEPT
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date < CURRENT_TIMESTAMP
ORDER BY assembly_step;

-- Other solution
SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;