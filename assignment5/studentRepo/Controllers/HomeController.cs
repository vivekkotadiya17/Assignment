using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using studentRepo.Models;
namespace studentRepo.Controllers;
public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly StudentContext _db;
    public HomeController(ILogger<HomeController> logger,StudentContext db)
    {
        _logger = logger;
        _db= db;
    }

    public IActionResult Index()
    {
        return View();
    }


    [HttpPost]
    public async Task<IActionResult> ProcessCsv(string filePath)
    {
        if (string.IsNullOrEmpty(filePath) || !System.IO.File.Exists(filePath))
        {
            ViewBag.Message = "Invalid file path. Please enter a correct file path.";
            return View("Index");
        }

        List<Student> students = new List<Student>();

        using (var streamReader = new StreamReader(filePath))
        {
            string line;
            bool isFirstLine = true;
            while ((line = streamReader.ReadLine()) != null)
            {
                if (isFirstLine) { isFirstLine = false; continue; } // Skip header

                var values = line.Split(',');

                if (values.Length < 7) continue; // Skip invalid rows

                var student = new Student
                {
                    Rollnumber = int.Parse(values[0]),
                    Name = values[1],
                    Mobilenumber = values[2].StartsWith("+91") ? values[2] : "+91" + values[2],
                    City = values[3],
                    Address = values[4],
                    Email = values[5],
                    Pincode = values[6]
                };

                if (string.IsNullOrEmpty(student.Email) || student.Pincode.Length > 6)
                    continue;

                students.Add(student);
            }
        }

        foreach (var student in students)
        {
            var existingStudent = await _db.Students.FirstOrDefaultAsync(s => s.Rollnumber == student.Rollnumber);
            if (existingStudent != null)
            {
                existingStudent.Name = student.Name;
                existingStudent.Mobilenumber = student.Mobilenumber;
                existingStudent.City = student.City;
                existingStudent.Address = student.Address;
                existingStudent.Email = student.Email;
                existingStudent.Pincode = student.Pincode;
            }
            else
            {
                _db.Students.Add(student);
            }
        }

        await _db.SaveChangesAsync();
        ViewBag.Message = "CSV data processed successfully!";
        return View("Index");
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}



