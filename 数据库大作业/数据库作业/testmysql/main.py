import tkinter
from tkinter import *
from tkinter import messagebox
from tkinter.ttk import Combobox
import pymysql
host = "localhost"
user = "root"#root用户
password = "123456"#密码
dbname = "system_choose_course"#数据库名

def update_info(v,e):
    try:
        db = pymysql.connect(host=host,
                             user=user,
                             password=password,
                             database=dbname, )
        cur = db.cursor()
        sql0 = "select 1 from major where Mname = '{}'"
        tag = cur.execute(sql0.format(e.get()))
        cur.callproc('p1', args=(e.get(), uid))
        db.commit()
        if tag == 1:
            # tag = 1,有这个专业
            tkinter.messagebox.showinfo("successful", "修改专业成功")
        else:
            tkinter.messagebox.showinfo("unsuccessful", "没有这个专业")
    except pymysql.Error as e:
        tkinter.messagebox.showinfo("unsuccessful", "操作失败" + str(e))
        db.rollback()
    db.close()


def person_info():
    try:
        db = pymysql.connect(host=host,
                             user=user,
                             password=password,
                             database=dbname,
                             )
        print("数据库连接成功")
        cur = db.cursor()
        sql = "SELECT * FROM studentinfo where sid = '{}'"
        cur.execute(sql.format(uid))
        results = cur.fetchall()
        return results

    except pymysql.Error as e:
        print("数据查询失败" + str(e))
    db.close()


def update_it(win):
    root = Toplevel(win)
    root.title("change_info")
    root.geometry("500x230")
    Label(root, text="{:<14}{:<14}{:<14}{:<14}{:<14}{:<14}".format(
        "学生编号", "姓名", "学院", "专业", "出生日期", "性别")).grid(row=0, column=0, columnspan=2,
                                                      pady=9, sticky="w")
    var = StringVar()
    rels = person_info()
    cb = Combobox(root, textvariable=var, width=17)
    cb["value"] = ("major")
    i = 1
    for rel in rels:
        s1 = (
            "{:<16}{:<16}{:<14}{:<14}{:<16}{:<16}".format(
                rel[0], rel[1], rel[2], rel[5], rel[4], rel[3]))
        Label(root, text=s1).grid(row=i, column=0, columnspan=2, padx=5, pady=30, sticky="w")
        i = i + 1

    e1 = Entry(root)
    Label(root, text="请选择将要修改的信息").grid(padx=5, row=i, pady=8, column=0, sticky="e")
    cb.grid(padx=5, row=i, column=1, pady=8, sticky="w")
    i = i + 1
    Label(root, text="请输入要修改的值").grid(padx=5, row=i, column=0, sticky="e")
    e1.grid(padx=5, row=i, column=1, sticky="w")
    Button(root, text="提交", command=lambda: update_info(var, e1)).grid(row=i + 1, column=0, columnspan=2)

#选课
def insert_course(e):
    try:
        db = pymysql.connect(host=host,
                             user=user,
                             password=password,
                             database=dbname, )
        cur = db.cursor()
        sql = "INSERT INTO sc(sId,cId) VALUES (%s,%s)"
        value = (uid, e.get())
        cur.execute(sql, value)
        db.commit()
        tkinter.messagebox.showinfo("successful", "插入成功")
    except pymysql.Error as e:
        tkinter.messagebox.showinfo("unsuccessful", "插入失败" + str(e))
        db.rollback()
    db.close()
#退课
def delete_course(e):
    try:
        db = pymysql.connect(host=host,
                             user=user,
                             password=password,
                             database=dbname, )
        cur = db.cursor() #使用cursor()方法获得操作游标
        sql0 = "select RC from sc,courseinfo " \
               "where sc.sId = %s and sc.cId = %s and sc.cId = courseinfo.cId"
        sql1 = "delete sc from sc,courseinfo " \
              "where sc.sId = %s and sc.cId = %s and sc.cId = courseinfo.cId and courseinfo.RC<>1"
        value = (uid, e.get())
        cur.execute(sql1, value)
        tag = cur.execute(sql0, value)
        db.commit() #提交到数据库执行
        if tag == 1:
            tkinter.messagebox.showinfo("unsuccessful", "必修课禁止退课,退课失败")
        else:
            tkinter.messagebox.showinfo("successful", "退课成功")
    except pymysql.Error as e:
        tkinter.messagebox.showinfo("unsuccessful", "退课失败" + str(e))
        db.rollback() # 发生错误时回滚 回滚到获取游标的位置开始重新执行
    db.close()

def cour_all():
    try:
        db = pymysql.connect(host=host,
                             user=user,
                             password=password,
                             database=dbname,
                             )
        print("数据库连接成功")
        cur = db.cursor()
        sql = "SELECT courseinfo.*,teacherinfo. tname ,classroom_arr. crId " \
              "FROM courseinfo,teach,teacherinfo,classroom,classroom_arr " \
              "WHERE  teach. tId =teacherinfo. tId  " \
                      "AND classroom. crId =classroom_arr. crId  " \
                      "AND classroom_arr. cId =courseinfo. cId  " \
                      "AND teach. cId =courseinfo. cId  " \
              "ORDER BY courseinfo. cId  "
        cur.execute(sql)
        results = cur.fetchall()
        return results

    except pymysql.Error as e:
        print("数据查询失败" + str(e))
    db.close()


def choose_course(win):
    root = Toplevel(win)
    root.title("choose_course")
    root.geometry("600x500")
    Label(root, text="课程编号   课程名称   课程介绍    课程学时       学分      课程星期    是否必修    班级号").grid(row=0, column=0,
                                                                                            columnspan=2,
                                                                                            padx=5, pady=9)
    rels = cour_all()
    i = 1
    for rel in rels:
        s1 = ("{:<14}{:<14}{:<9}{:>14}{:>14}{:>14}{:>14}{:>14}".format(
                rel[0], rel[1], rel[2], rel[3], rel[4], rel[5], rel[6], rel[7]))
        Label(root, text=s1).grid(row=i, column=0, columnspan=2, padx=5, pady=9)
        i = i + 1
    ee = Entry(root)
    Label(root, text="请填入要插入的课程编号").grid(padx=5, row=i, pady=20, column=0, sticky="e")
    ee.grid(padx=5, row=i, column=1, pady=10, sticky="w")
    Button(root, text="提交", command=lambda: insert_course(ee)).grid(row=i + 1, column=0, columnspan=2)
    i = i+2
    ee = Entry(root)
    Label(root, text="请填入要删除的课程编号").grid(padx=5, row=i, pady=20, column=0, sticky="e")
    ee.grid(padx=5, row=i, column=1, pady=10, sticky="w")
    Button(root, text="提交", command=lambda: delete_course(ee)).grid(row=i + 1, column=0, columnspan=2)


def chaKe():
    try:
        db = pymysql.connect(host=host,
                             user=user,
                             password=password,
                             database=dbname,
                             )
        print("数据库连接成功")
        cur = db.cursor()
        sql = "select * from v3"
        cur.execute(sql)
        results = cur.fetchall()
        return results
    except pymysql.Error as e:
        print("数据查询失败" + str(e))
    db.close()

def stu_course(win):
    root = Toplevel(win)
    root.title("stu_course")
    root.geometry("660x500")
    Label(root, text="学号    学生姓名    课程名称     课程号      课程介绍      课程学分     课程星期     老师姓名     班级号").pack(padx=5, pady=14,
                                                                                                    anchor="nw")
    rels = chaKe()
    for rel in rels:
        s1 = (
            "{:<10}{:<14}{:<14}{:<11}{:<16}{:<18}{:<15}{:<18}{:<14}".format(
                rel[0], rel[1], rel[2], rel[3], rel[4], rel[5], rel[6], rel[7], rel[8]))
        Label(root, text=s1).pack(padx=5, pady=14, anchor="nw")

#修改密码
def update_sql(table, pwd1, pwd2):
    if pwd1 == "":
        tkinter.messagebox.showwarning("error", "请不要输入空值")
    elif pwd2 != pwd1:
        tkinter.messagebox.showwarning("error", "上下密码不相等")
    else:
        try:
            db = pymysql.connect(host=host,
                                 user=user,
                                 password=password,
                                 database=dbname,
                                 )
            cur = db.cursor()
            sql = "UPDATE " + table + " SET pwd= " + pwd1 + " WHERE name= " + "'" + name + "'"
            cur.execute(sql)
            db.commit()
            tkinter.messagebox.showinfo("成功", "修改成功")
        except pymysql.Error as e:
            print(e)
            tkinter.messagebox.showinfo("失败", "修改失败")
            db.rollback()
        db.close()

#修改密码
def change_password(win, table):
    change_pwd = Toplevel(win)
    change_pwd.title("登录")
    change_pwd.geometry("350x200")
    idE = Entry(change_pwd, width=30)
    pwdE = Entry(change_pwd, width=30)
    Label(change_pwd, text="修改密码", font="微软雅黑 14").grid(row=0, column=0, columnspan=2, sticky="w",
                                                        pady=10)
    Label(change_pwd, text="新密码", font="微软雅黑 14").grid(row=1, column=0, sticky="w")
    idE.grid(row=1, column=1, sticky="e", padx=40)
    Label(change_pwd, text="确认密码", font="微软雅黑 14").grid(row=2, column=0, sticky="w")
    pwdE.grid(row=2, column=1, sticky="e", padx=40)
    Button(change_pwd, text="修改", font="宋体 14", relief="raised",
           command=lambda: update_sql(table, pwdE.get(), idE.get())).grid(row=3, column=0,
                                                                          columnspan=2,
                                                                          pady=20,
                                                                          padx=20)

def insert_stu(stuid,stuname):
    #pass
    try:
        db = pymysql.connect(host=host,
                             user=user,
                             password=password,
                             database=dbname, )
        cur = db.cursor()
        sql = "insert into studentinfo(sId,sname) values(%s,%s)"
        value = (stuid.get(),stuname.get())
        cur.execute(sql, value)
        db.commit()
        tkinter.messagebox.showinfo("successful", "添加学生成功")
    except pymysql.Error as e:
        tkinter.messagebox.showinfo("unsuccessful", "添加学生失败" + str(e))
        db.rollback()
    db.close()

def add_stu(win):
    #pass
    root = Toplevel(win)
    root.title("choose_course")
    root.geometry("600x500")
    i = 1
    ee = Entry(root)
    Label(root, text="请填入要添加的学生学号").grid(padx=5, row=i, pady=20, column=0, sticky="e")
    ee.grid(padx=5, row=i, column=1, pady=10, sticky="w")

    i = i + 2
    ee2 = Entry(root)
    Label(root, text="请填入要添加的学生姓名").grid(padx=5, row=i, pady=20, column=0, sticky="e")
    ee2.grid(padx=5, row=i, column=1, pady=10, sticky="w")
    Button(root, text="提交", command=lambda: insert_stu(ee,ee2)).grid(row=i + 1, column=0, columnspan=2)


def admin_operate():
    admin_log = Tk()
    admin_log.title("管理员操作台")
    admin_log.geometry("310x180")
    Label(admin_log, text="Hello," + name + "\n请选择您的操作\n"
          , font="微软雅黑 14", justify=LEFT).grid(row=0, column=0, columnspan=2, sticky='w')

    Button(admin_log, text="修改密码", font="宋体 14", relief="raised",
           command=lambda: change_password(admin_log, "stupwd")).grid(row=1, column=0)

    Button(admin_log, text="增加学生", font="宋体 14",relief="raised",
           command=lambda: add_stu(admin_log)).grid(row=2, column=0)
    #Button(admin_log, text="修改专业", font="宋体 14",relief="raised",
           #command=lambda: change_major(admin_log)).grid(row=3, column=0)


def stu_operate():
    stu_log = Tk()
    stu_log.title("学生操作台")
    stu_log.geometry("250x220")
    Label(stu_log, text="Hello," + name + "\n请选择您的操作\n"
          , font="微软雅黑 12", justify=LEFT).grid(row=0, column=0, columnspan=2, sticky="w", pady=10)
    Button(stu_log, text="修改密码", font="宋体 14", relief="raised",
           command=lambda: change_password(stu_log, "stupwd")).grid(row=1, column=0)
    Button(stu_log, text="选课", font="宋体 14", relief="raised",
           command=lambda: choose_course(stu_log)).grid(row=1, column=1, padx=80,sticky="e")
    Button(stu_log, text="查课", font="宋体 14", relief="raised",
           command=lambda: stu_course(stu_log)).grid(row=2,  column=0, pady=20, sticky="w")
    Button(stu_log, text="个人信息", font="宋体 14", relief="raised",
           command=lambda: update_it(stu_log)).grid(row=2,   column=1)


def check_pwd(s1, s2, DB):
    global name
    global uid
    try:
        db = pymysql.connect(host=host,
                             user=user,
                             password=password,
                             database=dbname,
                             )
        cur = db.cursor()
        sql = "select * from " + DB + " where id= " + s1 + " and " + " pwd= " + s2
        marked = cur.execute(sql)
        results = cur.fetchall()
        for row in results:
            uid = row[0]
            name = row[2]
        return marked
    except pymysql.Error as e:
        print("数据查询失败" + str(e))
    db.close()


def checkInfo(kind, e1, e2, w1):
    Id = e1.get()
    pwd = e2.get()
    if kind == "登陆":
        marked = check_pwd(Id, pwd, "stupwd")
        if marked:
            w1.destroy()
            stu_operate()
        else:
            messagebox.showerror("error", "password is not right,please input again")
    elif kind == "adminstrator login":
        marked = check_pwd(Id, pwd, "adminpwd")
        if marked:
            w1.destroy()
            admin_operate()
        else:
            messagebox.showerror("error", "password is not right,please input again")

def login(str, win):
    win.destroy()
    log_in = Tk()
    log_in.title("登录")
    log_in.geometry("350x200")
    idE = Entry(log_in, width=30)
    pwdE = Entry(log_in, width=30)
    Label(log_in, text=str, font="微软雅黑 14").grid(row=0, column=0, columnspan=2, sticky="w",
                                                 pady=10)
    Label(log_in, text="学号/工号", font="楷体 14").grid(row=1, column=0, sticky="w", )
    idE.grid(row=1, column=1, sticky="e", padx=20)
    Label(log_in, text="密码", font="楷体 14").grid(row=2, column=0, sticky="w")
    pwdE.grid(row=2, column=1, sticky="e", padx=20)
    Button(log_in, text="登录", font="宋体 14", relief="raised",
           command=lambda: checkInfo(kind=str, e1=idE, e2=pwdE, w1=log_in)).grid(row=3,
                                                                                 column=0,
                                                                                 columnspan=2,
                                                                                 pady=20,
                                                                                 padx=20)


name = ""
uid = ""
master = Tk()
master.title("欢迎")
master.geometry("420x200+500+200")

Label(text="您好!\n""欢迎登录学生选课系统\n""温馨提示：\n""初始密码为学号，初次登录请修改密码\n",
      font="楷体 17", justify=LEFT).grid(row=1, column=0, columnspan=2,
      sticky='w', pady=10)
Button(master, text="学生登录", font="宋体 14", relief="raised",justify=CENTER,
       command=lambda: login("登陆", master)).grid(sticky='w', row=3, column=0, pady=10)
Button(master, text="管理员登录", font="宋体 14", relief="raised",
       command=lambda: login("adminstrator login", master)).grid(sticky='e', row=3, column=1)#grid(row=4, column=0, columnspan=2, pady=10)
master.mainloop()

