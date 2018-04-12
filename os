#include<stdio.h>


struct process
{
	int a_time;
	int b_time;
	int f_time;
	int w_time;
	int cpu;
	float pr;
}p[20];
int time_unit=0;
int np,i,npl=0;
int d=0;

void showcase()
{	printf("\n Process number\t     arrival time\t    burst time");
	for(i=0;i<np;i++)
	{
		printf("\n\t   %d \t       %d\t\t       %d",i+1,p[i].a_time,p[i].b_time);
	}
}
void test_case1()
{	np=4;
	p[0].a_time=0;  p[0].b_time=20; p[0].pr=1;
	p[1].a_time=5;  p[1].b_time=36; p[1].pr=1;
	p[2].a_time=13; p[2].b_time=19; p[2].pr=1;
	p[3].a_time=17; p[3].b_time=42; p[3].pr=1;	
	printf("\n Test case is=> ");
	showcase();
}

int max_priority()
{
	float max=-1;
	int maxp=0;
	for(i=0;i<np;i++)
	{   
		if(p[i].a_time>=0 && p[i].a_time<=time_unit && p[i].b_time>0)
			{
			if(max<p[i].pr)
			{max=p[i].pr;
			maxp=i;
			}
			}
	}
	return maxp;
}

void processing(int n)
{	
	printf("\n\t\t time unit \t\t Process number");
	printf("\n\t\t     %d  \t\t\t P%d",time_unit,n+1);
	p[n].b_time--;
	p[n].cpu=1;
	if(p[n].b_time==0){p[n].f_time=time_unit;}
	
	
	for(i=0;i<np;i++)
	{
	if(i!=n && p[i].a_time<time_unit && p[i].b_time!=0)
	{
	p[i].w_time++;
	}	
	}
	
	for(i=0;i<np;i++)
	{if(p[i].b_time!=0)
	{		
	p[i].pr=(float)p[i].w_time/p[i].b_time;
	p[i].pr=p[i].pr+1;
	}
	else {p[i].pr=0;}
	}	
}

void processing2()
{printf("\n\t\t time unit \t\t Process number");
 printf("\n\t\t     %d  ",time_unit);}

int main()
{	int gp,flag,temp,j;
	float temp1=0,temp2=0;
	int avgw=0,avgtat=0,tat;
	test_case1();
	printf("\n\n Execution starting: \n");
	do
	{
	flag=0;
	for(i=0;i<np;i++)
	{
	if(p[i].b_time!=0)
	flag=1;	
	} 
		
		if(flag==1)
		{ 	gp=max_priority();
			temp=p[gp].b_time;
			if(temp==0)goto E;
			else{
			
			for(j=0;j<temp;j++)
			{E:
			time_unit++;
			if(p[gp].b_time>0)
				{processing(gp);}
		else
		{
			p[gp].pr=0;	
			processing2();
	   	 }}}
	   	 
		}
	}while(flag==1);
	
		printf("\n\n Total time units taken: %d",time_unit);
		
		for(i=0;i<np;i++)
		{ tat=0;
		if(p[i].cpu==1)
			{
		    	tat=p[i].f_time-p[i].a_time;
				avgw=avgw+p[i].w_time;
				avgtat=avgtat+tat;
				npl++;
			}
			printf("\n");
		  }
		if(npl>0)
		{
			temp1=(float)avgw/npl;
			temp2=(float)avgtat/npl;
		}
		printf("\n\n Average waiting time= %d/%d = %.2f",avgw,npl,temp1);
		printf("\n Average turn around time= %d/%d = %.2f",avgtat,npl,temp2);
	
		
return 0;
}
