//unity learning notes
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class note : MonoBehaviour
{
    /*
      //使用脚本创建物体
      Transform cube1 = GameObject.CreatePrimitive(PrimitiveType.Cube).transform as Transform;//电梯模块

      //变量设置
      protected float jump_speed = 3.0f; //设置起跳速度

  //移动
      this.transform.position = Vector3.up* 10; //设置位置
      this.transform.position += Vector3.left* Time.deltaTime; //Time.deltaTime为每帧用时
      this.GetComponent<Rigidbody>().velocity = Vector3.up* this.jump_speed;  //设定向上速度
      //镜头移动
          Vector3 a = Input.mousePosition;//鼠标当前位置

          // 得到鼠标当前位置
          float mouseX = Input.GetAxis("Mouse X");
          float mouseY = Input.GetAxis("Mouse Y");
          // 设置照相机和Player的旋转角度，X,Y值需要更具情况变化位置
          transform.localRotation = transform.localRotation * Quaternion.Euler(-mouseY, 0, 0);
          transform.localRotation = transform.localRotation * Quaternion.Euler(0, mouseX, 0);

  //事件触发
      //按键触发
          if (Input.GetKey(KeyCode.UpArrow)) { }




  OnTriggerEnter//碰撞
  OnTriggerStay//接触
  GetComponent//获取组建

  Debug.DrawLine//画线

  transform.Rotate//自转
  transform.RotateAround//公转
  transform.LookAt//镜头跟随

  lossyScale//相对世界大小(read only)
  localScale//相对父物体大小

  AnimationCurve.Evaluate//时间曲线

  transform.parent//改变父物体
  transform.root//返回层次最高的root
  transform.childCount//返回子物体数目
  Destroy(gameObject)//销毁物体,或组件

  gameObject.SetActive(false);//不激活该物体

      //位置关系
      transform.Find//寻找子物体或组件
      GameObject.Find//寻找子物体或组件
      IschildOf//判断是否为子物体
      transform.DetachChildren();//删除子物体
      Transform.GetChild(int index);//
      GetSiblingIndex();
      SetAsFirstSibling();
      SetAsLastSibling();
      SetSiblingIndex();

      //对象与组件
      OnEnable();//当对象变为可用或激活状态时此函数被调用
      OnDisable();//当对象变为不可用或非激活状态时此函数被调用
      OnDesttoy();//当对对象将被销毁时调用

      //获取组建
      [RequireComponent(typeof(Rigidbody))];
      GetComponent<>();
      gameObject.AddComponent<Rigidbody>();//对物体添加组件

      */

    // OnGUI
    private void OnGUI()
    {
        GUILayout.TextArea("");
    }

    ///// 刚体
    void f()
    {
        // 刚体
        //***需要有碰撞反应的一方,需要有Rigidbody
        Rigidbody rb = GetComponent<Rigidbody>();
        rb.AddForce(0, 0, 10, ForceMode.Impulse); //施加冲量
    }

    //碰撞检测
    private void OnTriggerEnter(Collider other) { }//开始触发被调用
    private void OnTriggerStay(Collider other) { }//触发期间每一帧都会被调用
    private void OnTriggerExit(Collider other) { }//结束触发时调用

    private void OnCollisionEnter(Collision collision) { }//可获取碰撞点信息
    private void OnCollisionStay(Collision collision) { }
    private void OnCollisionExit(Collision collision) { }



    /// <summary>
    /// 4.Transform场景物体的坐标变化
    /// </summary>

    //(1)坐标系
    void f4_1()
    {
        /*
        transform.forward   当前物体前方的世界坐标
        transform.right 
        transform.up
        
         
        transform.TransformPoint();          从自身位置到世界坐标
        transform.InverseTransformPoint();   从世界坐标到自身坐标
        transform.TransformDirection();      从自身方向到世界方向
        transform.InverseTransformDirection();


        eg
        if (Input.GetKey(KeyCode.F))
        {
            G.transform.position = transform.TransformPoint(0, 0, 3);
            G.transform.parent = transform;
            G.GetComponent<Rigidbody>().isKinematic = true;
        }
        if (Input.GetKey(KeyCode.G))
        {
            if (G.GetComponent<Rigidbody>().isKinematic == true)
            {
                G.GetComponent<Rigidbody>().isKinematic = false;
                transform.DetachChildren();
                G.GetComponent<Rigidbody>().AddForce(transform.forward * 12, ForceMode.Impulse);
            }
        }
        */
    }

    //(2)位移
    void f4_2()
    {
        /*
        //变量
        transform.position;
        transform.localPosition;

        //函数方法
        transform.Translate(0, Time.deltaTime * 0.1, 0, Space.Self) // Space.World或其他物体的transform);//更方便的表示位移

        eg:
        public AnimationCurve ac;
        transform.position = new Vector3(transform.position.x - Time.deltaTime, 2 + ac.Evaluate(Time.time), 0);
        */
    }

    //(3)旋转
    void f4_3()
    {
        /*
        //变量
        transform.eulerAngles = new Vector3...;
        transform.localEulerAngles;
        transform.rotation = new Quaternion...;
        transform.localRotation;



        //函数方法
        transform.Rotate();
        transform.RotateAround();
        transform.LookAt(); //z轴朝向该物体

        transform.rotation = Quaternion.RotateTowards(transform.rotation, Quaternion.LookRotation(G.transform.position - transform.position), speed * Time.deltaTime);//匀速想G转
        Quaternion.RotateTowards();
        LookRotation()
        Quaternion.FromToRotation();


        //Dedug     
        Debug.DrawLine();
        GUILayout.TextArea(Time.time.ToString());

   
        */


    }

    //(4)缩放
    void f4_4()
    {
        /*
        transform.lossyScale;//相对世界大小(只读)
        transform.localScale;//相对父物体大小
        */
    }

    //（5）位置关系
    void f4_5()
    {
        /*
        //变量
        transform.parent;   get+set
        transform.root;     get
        transform.childCount;   get


        //函数方法
        transform.Find();  返回transform,    GameObject.Find()返回GameObject
        transform.IsChildOf();
        transform.DetachChildren();   断绝所有与子的关系
        transform.GetChild(int index);
        transform.GetSiblingIndex();
        transform.SetAsFirstSibling();
        transform.SetAsLastSibling();
        transform.SetSiblingIndex();
        */

    }

    /// <summary>
    /// 5.脚本开发中的基础数学
    /// </summary>
    
    //(1)Time时间体系
    void f5_1()
    {
        /*
        //可读写变量
        Time.fixedDeltaTime;//物理运算刷新间隔
        Time.maximumDeltaTime; //一帧能获得的最大时间
        Time.timeScale;//时间缩放
        Time.captureFramerate;//时间会以每帧（1.0/captureFramerate）前进，不考虑真实时间

        //只读变量
        Time.time;//游戏运行多长时间
        Time.timeSinceLevelLoad;//此场景开始到现在的时间
        Time.deltaTime; //每帧间隔时间
        Time.fixedTime;//自游戏开始到现在的时间(暂停不影响)
        Time.smoothDeltaTime;//加权平均的Time.deltaTime
        Time.frameCount;//已传递的总帧数
        Time.realtimeSinceStartup;//自由游戏开始的真实时间
        Time.unscaledDeltaTime;//每帧时间间隔，不受Time.timeScale影响
        Time.unscaledTime;//从游戏开始到现在的时间,不受Time.timeScale影响
        */
    }

    //(2)Random随机数
    void f5_2()
    {
        /*
        //可读写变量
        Random.seed;//设置随机数种子

        //只读变量
        Random.value;//返回一个0.0 - 1.0之间的数
        Random.insideUnitCircle;//返回一个二维圆内的数
        Random.insideUnitSphere;//返回一个三维球体内的数
        Random.onUnitSphere;//返回一个球面上的随机数
        Random.rotation;//返回一个随机旋转角度
        Random.rotationUniform;//返回一个随机旋转角度(平均分布)
        Random.Range(min,max);//返回一个min - max的随机数
        */
    }

    //(3)Mathf数学运算
    void f5_3()
    {
        /*
        Mathf.Round();//就近取整  .5偶舍，奇数入

        //曲线变换
        Mathf.Lerp();//基于浮点数t返回a到b之间的插值
        Mathf.LerpAngle();//基于浮点数t返回a到b之间的角度插值
        Mathf.MoveTowards();//改变一个当前值向目标值靠近
        Mathf.MoveTowardsAngle();//改变一个当前值向目标角度靠近
        Mathf.SmoothStep();//和lerp类似，在最小和最大值之间的插值,并在限制处渐入渐出
        Mathf.SmoothDamp();//随着时间的推移逐渐改变一个值到期望值
        Mathf.SmoothDampAngle();//随着时间的推移逐渐改变一个值到期望角度

        //其他有用的方法函数
        Mathf.InverseLerp();//与Mathf.Lerp()相反
        Mathf.Repeat();//重复
        Mathf.PingPong();//y对称重复
        Mathf.LinearToGammaSpace();//颜色变化
        Mathf.GammaToLinearSpace();//颜色变化
        Mathf.PerlinNoise();//渐变随机数（参数0-10）


        */
    }


    /// <summary>
    /// 6.脚本开发中的3D数学
    /// </summary>
    void f6_1()
    {
        /*
        //静态变量与实例方法
        Vector3.Dot(VectorA,VectorB);//点积
        Vector3.Cross(VectorA, VectorB);//叉乘
        Vector3.Magnitude();//标量平方
        Vector3.SqrMagnitude();//标量
        Vector3.Normalize();//求出其单位向量
        Vector3 V = new Vector3();V.normalized;//单位向量,不会改变V
        V.Normalize();//会改变V;

        //静态方法(最重要的部分)
        Vector3.Angle(V1,V2);//V1,V2的夹角
        Vector3.ClampMagnitude();//限制位置在一点的半径范围内
        Vector3.Cross(VectorA, VectorB);//叉乘
        Vector3.Distance(,);//两点之间的距离
        Vector3.Dot(VectorA, VectorB);//点积
        Vector3.Lerp();//坐标位置线性插值
        Vector3.Min();//(1,3,2),(2,1,4)返回(1,1,2)
        Vector3.Max();
        Vector3.MoveTowards();//从一点到另一点的
        Vector3.Normalize();//求出向量的单位向量
        Vector3.RotateTowards();//a到b旋转速度与移动速度
        Vector3.Slerp();//旋转插值
        Vector3.Scale();//(1,2,3),(2,3,1)fanhui(2,6,3)

            //较难的函数方法
        Vector3.OrthoNormalize();
        Vector3.Project();     //投影
        Vector3.ProjectOnPlane();  //投影
        Vector3.Reflect(); //镜像
        */
    }

    /// <summary>
    /// 7.脚本开发中的输入与控制
    /// </summary>
    
    void f7()
    {
        /*
        //键盘输入
        Input.GetKey(); //触发返回true,不触发返回false
        Input.GetButton(); //触发返回true,不触发返回false
        Input.GetButtonDown();//按下时触发一次
        Input.GetButtonUp();//按键抬起是触发一次
        Input.GetAxis();//返回-1 到 1的float
        Input.GetAxisRaw();//键盘返回-1,0,1
        */
    }

    //鼠标输入
    private void OnMouseEnter() {}//开始时触发
    private void OnMouseOver() {}//期间触发
    private void OnMouseExit() {}//结束时触发
    private void OnMouseDown() {}//点击调用
    private void OnMouseUp() {}//点击结束调用
    private void OnMouseDrag() {}//拖拽物体时触发
    private void OnMouseUpAsButton() {}//按下GUI组件时触发

    //Raycast
    void f7_1()
    {
        /*
        Physics.Raycast(ray,hit,len);//射线，ray射线起点，方向    hit碰撞体信息   len射线长度



        */
    }

}































