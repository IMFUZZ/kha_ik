package character;

import Math;
import kha.math.Vector2;

class IK {
	public static function lastBoneAngle(targetPos:Vector2, d1:Float, d2:Float):Float {
		var numerator:Float = Math.pow(targetPos.x, 2)+Math.pow(targetPos.y, 2)-Math.pow(d1, 2)-Math.pow(d2, 2);
		var denominator:Float = (2*d1*d2);
		var cosAngle:Float = numerator/denominator;
		if (cosAngle < -1 || cosAngle > 1) {
			cosAngle = 1;
		}
		return Math.acos(cosAngle);
	}

	public static function secondaryAngle(angle:Float, targetPos:Vector2, d1:Float, d2:Float):Float {
		var triAdjacent:Float = (d1+(d2*Math.cos(angle)));
		var triOpposite:Float = (d2*(Math.sin(angle)));
		return Math.atan2((targetPos.y*triAdjacent - targetPos.x*triOpposite), (targetPos.x*triAdjacent + targetPos.y*triOpposite));
	}

	public static function getIKPositions(originPos:Vector2, targetPos:Vector2, d1:Float, d2:Float) {
		var endAngle:Float = IK.lastBoneAngle(targetPos, d1, d2);
		var rootAngle:Float = IK.secondaryAngle(endAngle, targetPos, d1, d2);
		endAngle += rootAngle;
		var rootPos:Vector2 = new Vector2(originPos.x + Math.cos(rootAngle)*d2, originPos.y + Math.sin(rootAngle)*d2);
		var endPos:Vector2 = new Vector2(rootPos.x + Math.cos(endAngle)*d1, rootPos.y + Math.sin(endAngle)*d1);
		return [rootPos, endPos];
	}
}