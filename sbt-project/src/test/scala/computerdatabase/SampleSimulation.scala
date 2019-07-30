/*
 * Copyright 2011-2019 GatlingCorp (https://gatling.io)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package computerdatabase

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

import com.typesafe.scalalogging.Logger
import org.slf4j.LoggerFactory

class SampleSimulation extends Simulation {
  val logger = Logger(LoggerFactory.getLogger(this.getClass))
  logger.debug("log test")
  val httpProtocol = http
    .baseUrl("http://weather.livedoor.com") // Here is the root for all relative URLs
    .acceptHeader("application/json") // Here are the common headers

  val scn = scenario("Scenario Name") // A scenario is a chain of requests and pauses
    // 10回連続で繰り返す
    .repeat(10, "i") {
      exec(http("request_${i}")
        .get("/forecast/webservice/json/v1?city=130010")
        .check(status.is(200))
      )
    }

  setUp(scn.inject(atOnceUsers(1)).protocols(httpProtocol))
    .assertions(
      // 最大レスポンスタイムが 50〜100m秒 かどうかチェック
      // global.responseTime.max.between(50, 100),
      // 3rd percentile(90パーセンタイル) <= 40m秒 かどうかチェック
      global.responseTime.percentile(90).lte(40)
    )
}
