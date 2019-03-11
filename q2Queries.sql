SELECT c.name, cr.grade FROM courses c, student_registrations sr, course_registrations cr, course_offers co WHERE sr.sID = %1% AND sr.dID = %2% AND sr.rID = cr.rID AND cr.offerID = co.offerID;
SELECT sID FROM Q2 WHERE AVG > %1%;
WITH fmstudents(numF, numM, dID) AS ( SELECT COUNT(students) FILTER (where gender = 'F'), COUNT(students) FILTER (where gender = 'M'), degrees.dID FROM student_registrations, degrees, students WHERE student_registrations.dID = degrees.dID AND student_registrations.sID = students.sID GROUP BY degrees.dID) SELECT fmstudents.dID, (100* fmstudents.numF/(fmstudents.numF+ fmstudents.numM) ) as percentage FROM fmstudents;
WITH fmstudents(numF, numTOT, dID) AS (SELECT COUNT(students) FILTER (where gender = 'F'), COUNT(students), degrees.dID FROM student_registrations, degrees, students WHERE degrees.dept = %1% AND degrees.dID = student_registrations.dID AND student_registrations.sID = students.sID GROUP BY degrees.dID) SELECT fmstudents.dID, (100* cast(fmstudents.numF as float)/fmstudents.numTOT) as percentage FROM fmstudents;
SELECT co.cID, (100*cast(count(cr.grade) filter (Where cr.grade >= 5) as float)/ count(cr.grade)) as percentage FROM course_offers co, course_registrations cr where cr.offerID = co.offerID and cr.grade is not null Group By co.cID;
SELECT 0;
SELECT 0;
WITH required_assistants (offerID, nr) AS (SELECT cr.offerID, 1+COUNT(cr.rID)/50 FROM course_registrations cr GROUP BY cr.offerID), actual_assistants(offerID, nr) AS (SELECT offerID, COUNT(sa.rID) FROM student_assistants sa GROUP BY sa.offerID) SELECT c.name, co.year, co.quartile, co.offerID, aa.nr as actual_count, ra.count as required_count FROM required_assistants ra, actual_assistants aa, course_offers co, courses c WHERE co.offerID = ra.offerID AND co.cID = c.cID AND aa.offerID = co.offerID AND aa.count < ra.count ORDER BY co.offerId;
