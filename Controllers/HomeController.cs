using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using Newtonsoft.Json;
using Nikhil_WebMobi.Models;

namespace Nikhil_WebMobi.Controllers
{
    public class HomeController : Controller
    {
        dbWebMobiEntities dbWeb = new dbWebMobiEntities();
        public ActionResult Index(int? id)
        {
            

            clsEmployee objEmp = new clsEmployee();
            
                var selectList = new List<SelectListItem>();

                //foreach (var item in DeptList)
                //{
                //    selectList.Add(new SelectListItem { Text = item.Department1, Value = item.DeptID.ToString() });
                //}
                dbWeb.Departments.ToList().ForEach(j => selectList.Add(new SelectListItem { Text = j.Department1, Value = j.DeptID.ToString() }));
                objEmp.liDept = selectList;

                objEmp.liGender = new List<radioData> {
                                                    new radioData {rText="Male",rValue="M"},
                                                    new radioData{rText="Female",rValue="F" },
                                                    new radioData {rText="Other",rValue="O"}
                                                  };
            if (id != null)
            {
                var detail = dbWeb.Employees.Where(j => j.EmpID == id).FirstOrDefault();
                objEmp.EmpID = detail.EmpID;
                objEmp.FirstName = detail.FirstName;
                objEmp.lastName = detail.LastName;
                objEmp.Gender = detail.Gender;
                objEmp.DeptID = Convert.ToInt32(detail.DepartmentID);
                objEmp.DOB = Convert.ToDateTime(detail.DOB);
                objEmp.imgUrl = detail.ImgUrl;                
            }




            return View(objEmp);
        }

        
       

        [HttpPost]
        public ActionResult Index(clsEmployee objEmp,string submit)
        {
            //Employee emp = new Employee();
            //emp.DepartmentID = objEmp.DepartmentID;
            if(objEmp.fuImage!=null)
            {
                string path = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                objEmp.imgUrl = "~/Uploads/" + Path.GetFileName(objEmp.fuImage.FileName);
                objEmp.fuImage.SaveAs(path + Path.GetFileName(objEmp.fuImage.FileName));
            }
            int result = 0; string strResult = "";
            switch (submit)
            {
                case "Add Employee":
                    result = dbWeb.spEmployee("I", null, objEmp.FirstName, objEmp.lastName, objEmp.Gender, objEmp.DOB, objEmp.imgUrl, objEmp.DeptID, true);
                    strResult = "Data saved successfully.";
                    break;
                case "Update Employee":
                    result = dbWeb.spEmployee("U", objEmp.EmpID, objEmp.FirstName, objEmp.lastName, objEmp.Gender, objEmp.DOB, objEmp.imgUrl, objEmp.DeptID, true);
                    strResult = objEmp.EmpID != 0 & result > 0 ? "Data updated successfully." : "Pls select the record";
                    break;
                case "Delete Employee":
                    result = dbWeb.spEmployee("D", objEmp.EmpID, objEmp.FirstName, objEmp.lastName, objEmp.Gender, objEmp.DOB, objEmp.imgUrl, objEmp.DeptID, false);
                    strResult = objEmp.EmpID != 0 & result > 0 ? "Data deleted successfully." : "Pls select the record";                    
                    break;
            }
            
            if (result >= 1)            
                ViewBag.Message = strResult;
            else
                ViewBag.Message = "try again!!";

            objEmp = new clsEmployee();

            var selectList = new List<SelectListItem>();
            
            dbWeb.Departments.ToList().ForEach(j => selectList.Add(new SelectListItem { Text = j.Department1, Value = j.DeptID.ToString() }));
            objEmp.liDept = selectList;

            objEmp.liGender = new List<radioData> {
                                                    new radioData {rText="Male",rValue="M"},
                                                    new radioData{rText="Female",rValue="F" },
                                                    new radioData {rText="Other",rValue="O"}
                                                  };
            return View(objEmp);
        }


        [HttpGet]
        public ActionResult getDetail()
        {
            
            return View();
        }
        [HttpPost]
        public ActionResult getEmpDetail()
        {
            List<vwEmpDetail> liJQ = new List<vwEmpDetail>();
            using (dbWebMobiEntities db1 = new dbWebMobiEntities())
            {
                liJQ = db1.vwEmpDetails.ToList<vwEmpDetail>();
            }
            return Json(new { data = liJQ }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult insertEmployee(clsEmployee objEmp)
        {
            //Employee emp = new Employee();
            //emp.DepartmentID = objEmp.DepartmentID;

            return View();
        }
    }
}