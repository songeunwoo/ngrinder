/* 
 * Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License. 
 */
package org.ngrinder;

import org.hyperic.jni.ArchNotSupportedException;
import org.hyperic.sigar.Sigar;
import org.junit.Before;
import org.junit.Test;

import java.io.File;
import java.io.IOException;

/**
 * TestBase for sigar lib path
 * 
 */
public class SigarTestBase {

	@Before
	public void setupSigarLibPath() throws IOException {
		System.setProperty("java.library.path", System.getProperty("java.library.path") + File.pathSeparator
						+ new File(""));
    }

    @Test
    public void test() throws IOException, ArchNotSupportedException {
       Sigar sigar = new Sigar();
    }
}
