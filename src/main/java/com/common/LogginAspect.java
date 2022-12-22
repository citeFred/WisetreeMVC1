package com.common;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
//@Component
public class LogginAspect {
	
	@Pointcut("execution(public * com.board..*(..))")
	private void logginTarget() {
		/* @Pointcut을 특정 메서드 앞에 기술할 수 있다.
		 * 이때 주의사항 @Pointcut이 적용된 메서드는 반환타입이 void여야 한다
		 * */
	}
	
	//@Around("logginTarget()")
	public Object trace(ProceedingJoinPoint jp) throws Throwable{
		Object[] args=jp.getArgs();
		String str=jp.getSignature().toShortString();
		System.out.println(str+"시작 . . . ");
		if (args!=null) {
			for(Object arg: args) {
				System.out.println("파라미터들: "+arg.toString());
			}
		}
		long start=System.nanoTime();
		try {
			Object result=jp.proceed();
			return result;
		} finally {
			long end=System.nanoTime();
			System.out.println(str+"종료 . . .");
			System.out.println(str+"실행시간: "+(end-start)+"ns");
			System.out.println("------------------------------");
		}
		
	}
}
