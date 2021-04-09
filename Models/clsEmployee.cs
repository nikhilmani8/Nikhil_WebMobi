using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Nikhil_WebMobi.Models
{
    public class clsEmployee
    {

        public int EmpID { set; get; }

        [Required(ErrorMessage = "Required")]
        [StringLength(300, ErrorMessage = "not greater than 300")]
        public string FirstName { set; get; }

        [Required(ErrorMessage = "Required")]
        [StringLength(300, ErrorMessage = "not greater than 300")]
        public string lastName { set; get; }

        [Required(ErrorMessage = "Required")]
        [StringLength(300, ErrorMessage = "not greater than 300")]
        public string Gender { set; get; }

        [Required]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:dd/MMM/yyyy}")]
        public DateTime DOB { get; set; }

        public string imgUrl { get; set; }

        public int DeptID { get; set; }

        public bool isActive { get; set; }

        [NotMapped]
        public IEnumerable<SelectListItem> liDept { get; set; }
        [NotMapped]
        public List<radioData> liGender { get; set; }

        [NotMapped]
        public HttpPostedFileBase fuImage { get; set; }

        [NotMapped]
        public List<vwEmpDetail> EmpDetails { get; set; }
    }

    public class radioData
    {
        public string rText { get; set; }
        public string rValue { get; set; }
    }


    public class JqDataObj
    {
        public int EmpID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }

        public string DOB { get; set; }
        public string FGender { get; set; }
        public string Gender { get; set; }
        public string Department { get; set; }
        public int DeptID { get; set; }
        public string imgUrl { get; set; }
    }
}