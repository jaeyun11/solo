package time;

import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class GetTime {
	public static void main(String[] args) {
		Timer timer = new Timer(true);
		
		TimerTask task = new TimerTask() {
			@Override
			public void run() {
				System.out.println("안녕하세요" + "\t" + new Date());
			}
		};
		
		timer.scheduleAtFixedRate(task, 1000, 3000);
		System.out.println("시작합니다" + "\t" + new Date());
		
		try {
			Thread.sleep(1000*20);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		timer.cancel();
		System.out.println("종료합니다" + "\t" + new Date());
	}
}
